terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "random_id" "key" {
  byte_length = 4
}

resource "digitalocean_ssh_key" "oba" {
  name       = "oba-key-${random_id.key.hex}"
  public_key = local_file.public_key.content

  depends_on = [local_file.public_key]
}

resource "digitalocean_droplet" "main" {
  name     = var.vm_name
  region   = var.region
  size     = var.size
  image    = "docker-20-04"
  ssh_keys = [digitalocean_ssh_key.oba.fingerprint]

  user_data = <<-EOF
  #!/bin/bash
  mkdir -p /home/${var.user}
  cd /home/${var.user}

  # clone repo
  git clone https://github.com/onebusaway/onebusaway-docker.git

  cd /home/${var.user}/onebusaway-docker

  # create .env file
  echo "${file("${path.module}/.env")}" > .env

  # onebusaway-api-webapp depends on mysql, normally this will handle by docker-compose
  # but in Azure, the mysql container will not be ready when onebusaway-api-webapp starts
  # which leads to the error `Access to DialectResolutionInfo cannot be null when 'hibernate.dialect' not set`
  # so we need to start mysql container first
  docker compose -f docker-compose.prod.yml up -d oba_database

  sleep 5s

  # start Docker Compose
  docker compose -f docker-compose.prod.yml up -d

  if [ -n "${var.caddy}" ]; then
      # create docker-compose.caddy.yml
      echo "${file("${path.module}/docker-compose.caddy.yml")}" > docker-compose.caddy.yml
      # start Caddy
      docker compose -f docker-compose.caddy.yml up -d
  fi

  ufw allow 8080/tcp
  EOF

  tags = ["web"]

  depends_on = [tls_private_key.ssh_key]
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

# remove ssh keys after destroy
resource "null_resource" "remove_ssh_keys" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    # replace with `del ${path.module}\\ssh\\id_rsa ${path.module}\\ssh\\id_rsa.pub` on Windows
    command = "rm -f ${path.module}/ssh/id_rsa ${path.module}/ssh/id_rsa.pub"
    when    = destroy
  }
}
