terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.11.0"
    }
  }
  required_version = ">=1.2.0"
  backend "s3" {
    bucket         = "dob-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dob_tf_locks"
  }
}
provider "aws" {
  region = var.region
}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

