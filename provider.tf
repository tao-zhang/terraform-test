terraform {
  required_version = ">= 1.15.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}

provider "random" {
  # Configuration options
}
