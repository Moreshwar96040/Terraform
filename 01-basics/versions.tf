# -------------------------------------------------------------
# TERRAFORM BLOCK
# Declares the required Terraform version and provider versions.
# This is best practice — locks versions so your code doesn't
# break if Terraform or the AWS provider releases breaking changes.
# -------------------------------------------------------------
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"   # "~> 5.0" means >= 5.0.0 and < 6.0.0
    }
  }
}
