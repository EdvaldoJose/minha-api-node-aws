terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
  required_version = ">= 1.2.0"
}

# provider "aws" {
#   region = var.aws_region
# }

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
