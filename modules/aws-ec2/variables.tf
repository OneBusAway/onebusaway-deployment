variable "region" {
  type        = string
  description = "AWS region to deploy resources."
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  description = "AWS availability zone in the region to deploy resources."
  default     = "us-east-1a"
}

variable "username" {
  type        = string
  description = "username for the VM."
  default     = "ubuntu"
}

variable "caddy" {
  description = "Wheather to use Caddy or not, leave empty to disable"
  type        = string
  default     = "1"
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
  description = "EC2 instance type, you can find details here: https://cloudprice.net/aws/ec2/instances/t3.medium."
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group."
  default     = "oba-security-group"
}
