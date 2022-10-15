terraform {
  required_version = ">= 0.12.20, < 2.0"

  required_providers {
    aws = {
      version = ">= 3.0, < 4.0"
      source  = "hashicorp/aws"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=0.1.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = ">=2.2.0"
    }
  }
}
