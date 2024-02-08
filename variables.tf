variable "env" {
  default     = "dev"
  description = "Environment"
}

variable "random_uuid" {
  default     = "fa37a7ec"
  description = "Random UUID to ensure uniqueness"
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "aws_athena_database_name" {
  default     = "bixtech-${var.env}"
  description = "Name of the Athena database"
}