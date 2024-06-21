# Tearrform configurations to restrict tearraform and aws versions.
terraform {
  required_version = "~>1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}