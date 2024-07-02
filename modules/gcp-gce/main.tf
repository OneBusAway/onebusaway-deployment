provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.main.id
}

resource "google_compute_address" "main" {
  name   = var.public_ip_name
  region = var.region
}

resource "google_compute_firewall" "main" {
  name    = var.firewall_name
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ssh/id_rsa"
}

resource "local_file" "public_key" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "${path.module}/ssh/id_rsa.pub"
}

data "template_file" "main" {
  template = file("${path.module}/init.tpl")
  vars = {
    user           = var.admin_username,
    caddy          = var.caddy,
    docker_compose = file("${path.module}/docker-compose.caddy.yml"),
    docker_env     = file("${path.module}/.env")
  }
}

resource "google_compute_instance" "main" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.main.id
    access_config {
      nat_ip = google_compute_address.main.address
    }
  }

  metadata_startup_script = data.template_file.main.rendered

  metadata = {
    ssh-keys = "${var.admin_username}:${tls_private_key.ssh_key.public_key_openssh}"
  }


  service_account {
    email  = google_service_account.main.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["onebusaway"]
}

resource "google_service_account" "main" {
  account_id   = "onebusaway-sa"
  display_name = "Onebusaway Service Account"
}

resource "null_resource" "remove_ssh_keys" {
  triggers = {
    always_run = timestamp()
  }

  # replace with `del ${path.module}\\ssh\\id_rsa ${path.module}\\ssh\\id_rsa.pub` if you are using Windows
  provisioner "local-exec" {
    command = "rm -f ${path.module}/ssh/id_rsa ${path.module}/ssh/id_rsa.pub"
    when    = destroy
  }
}
