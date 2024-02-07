variable "env" {
  default     = "dev"
  description = "Environment"
}

variable "account_id" {
  default     = "022696592384"
  description = "AWS account ID"
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "aws_athena_database_name" {
  default     = "bixtech-${var.env}"
  description = "Name of the Athena database"
}