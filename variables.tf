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

variable "aws_db_instance_name" {
  default     = "bixtech-postgres"
  description = "Database name"
}

variable "bucket_names" {
  description = "Buckets names"
  default = {
    raw     = "raw"
    trusted = "trusted"
    refined = "refined"
  }
}

variable "database_subnets" {
  description = "Database Subnets"
  default = {
    subnet-1 = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a", tag_name = "subnet-database-tf-1" }
    subnet-2 = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b", tag_name = "subnet-database-tf-3" }
    subnet-3 = { cidr_block = "10.0.3.0/24", availability_zone = "us-east-1c", tag_name = "subnet-database-tf-2" }
  }
}