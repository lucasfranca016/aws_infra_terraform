# Define the required Terraform version
terraform {
  required_version = "1.7.2"

  # Define required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Source of the AWS provider
      version = "5.35.0"        # Version of the AWS provider
    }
  }

  # Define Terraform backend configuration for storing state
  # Create a bucket with the name below and active version
  backend "s3" {
    bucket = "bixtech-terraform-states"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

# Define the AWS provider configuration
provider "aws" {
  region = var.aws_region # Specify the AWS region using the variable

  # Set default tags for resources created by Terraform
  default_tags {
    tags = {
      env        = var.env     # Tag for environment, using the env variable
      managed-by = "terraform" # Tag indicating that resources are managed by Terraform
    }
  }
}