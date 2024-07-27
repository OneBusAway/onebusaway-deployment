provider "aws" {
  region = var.region
}

locals {
  liveness_probe_path                  = "/onebusaway-api-webapp/api/where/current-time.json?key=org.onebusaway.iphone"
  liveness_probe_port                  = 8080
  liveness_probe_initial_delay_seconds = 120
  liveness_probe_period_seconds        = 30
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
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
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
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

resource "aws_efs_file_system" "main" {
  creation_token = "ecs-efs-oba"
}

resource "aws_efs_mount_target" "main" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.main.id]
}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.container_name}"
  retention_in_days = 7
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.container_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name              = var.container_name
    image             = var.container_image
    cpu               = var.container_cpu
    memory            = var.container_memory
    memoryReservation = var.container_memory
    essential         = true

    environment = [
      { name = "TZ", value = var.env_var_tz },
      { name = "GTFS_URL", value = var.env_var_gtfs_url },
      { name = "VEHICLE_POSITIONS_URL", value = var.env_var_vehicle_positions_url },
      { name = "TRIP_UPDATES_URL", value = var.env_var_trip_updates_url },
      { name = "ALERTS_URL", value = var.env_var_alerts_url },
      { name = "REFRESH_INTERVAL", value = var.env_var_refresh_interval },
      { name = "AGENCY_ID", value = var.env_var_agency_id },
      { name = "FEED_API_KEY", value = var.env_var_feed_api_key },
      { name = "FEED_API_VALUE", value = var.env_var_feed_api_value },
      { name = "JDBC_USER", value = var.env_var_jdbc_user },
      { name = "JDBC_PASSWORD", value = var.env_var_jdbc_password },
      { name = "JDBC_URL", value = var.env_var_jdbc_url },
      { name = "GOOGLE_MAPS_API_KEY", value = var.env_var_google_maps_api_key },
      { name = "GOOGLE_MAPS_CHANNEL_ID", value = var.env_var_google_maps_channel_id },
      { name = "GOOGLE_MAPS_CLIENT_ID", value = var.env_var_google_maps_client_id },
    ]

    portMappings = [
      {
        containerPort = 8080
        hostPort      = 8080
        protocol      = "tcp"
      }
    ]

    mountPoints = [
      {
        sourceVolume  = "bundle"
        containerPath = "/bundle"
        readOnly      = false
      }
    ]

    healthCheck = {
      command     = ["CMD-SHELL", "curl -f http://localhost:8080${local.liveness_probe_path} || exit 1"]
      interval    = local.liveness_probe_period_seconds
      timeout     = 5
      retries     = 3
      startPeriod = local.liveness_probe_initial_delay_seconds
    }

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = "/ecs/${var.container_name}"
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  volume {
    name = "bundle"

    efs_volume_configuration {
      file_system_id = aws_efs_file_system.main.id
      root_directory = "/"
    }
  }

  depends_on = [
    aws_efs_file_system.main, aws_efs_mount_target.main
  ]
}

resource "aws_ecs_service" "main" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.main.id]
    security_groups  = [aws_security_group.main.id]
    assign_public_ip = true
  }
}
