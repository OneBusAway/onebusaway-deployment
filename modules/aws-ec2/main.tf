provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  name   = var.security_group_name

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP on 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ec2-key-pair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_instance" "main" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [aws_security_group.main.id]
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = true

  user_data = base64encode(templatefile("${path.module}/init.tpl", {
    user           = var.username,
    caddy          = var.caddy,
    docker_compose = file("${path.module}/docker-compose.caddy.yml"),
    docker_env     = file("${path.module}/.env")
  }))
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ssh/id_rsa"
}

# resource "null_resource" "set_permission" {
#   depends_on = [local_sensitive_file.private_key]
#
#   provisioner "local-exec" {
#     command = "chmod 0600 ${local_sensitive_file.private_key.filename}"
#   }
# }

resource "local_file" "public_key" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "${path.module}/ssh/id_rsa.pub"
}

# Fetch the latest Ubuntu Server AMI for the provided region and instance type
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Remove ssh keys after destroy
resource "null_resource" "remove_ssh_keys" {
  triggers = {
    always_run = timestamp()
  }

  # replace `rm` with `del` if you are using Windows
  provisioner "local-exec" {
    command = "rm ${path.module}\\ssh\\id_rsa ${path.module}\\ssh\\id_rsa.pub"
    when    = destroy
  }
}


