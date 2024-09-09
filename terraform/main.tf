terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "github-oidc-terraform-poc-tfstates"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-04f76ebf53292ef4d"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-08ecc36cd37a82e6b"]
  subnet_id              = "subnet-03bad56679c8d253c"

  tags = {
    Name = "BackstageServerInstance"
  }
}
