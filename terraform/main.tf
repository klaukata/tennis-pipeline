terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# credentials 4 connecting to an acc
# entered credentials are saved as an env vars (file ~/shell_scripts/obtain_credentials.sh)
provider "aws" {}