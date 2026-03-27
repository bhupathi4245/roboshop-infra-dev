terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0"
    }
  }

  backend "s3" {
    bucket = "akinfo-remote-state-dev"
    key    = "roboshop-dev-user"
    region = "us-east-1"
    encrypt        = true
    use_lockfile = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}