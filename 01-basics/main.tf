# =============================================================
# PHASE 1 — LESSON 1: Your First Terraform Config
# What this builds: An S3 bucket (the "Hello World" of AWS IaC)
# =============================================================

# -------------------------------------------------------------
# PROVIDER BLOCK
# Tells Terraform: "We're working with AWS, in this region."
# Terraform downloads the AWS plugin when you run `terraform init`.
# -------------------------------------------------------------
provider "aws" {
  region = "ap-south-1"   # change to your preferred AWS region
}

# -------------------------------------------------------------
# RESOURCE BLOCK
# Syntax:  resource "<provider>_<type>" "<local_name>" { ... }
# - "aws_s3_bucket" = the AWS resource type (from AWS provider docs)
# - "my_first_bucket" = a local label YOU choose (used to reference
#   this resource elsewhere in your code, e.g., aws_s3_bucket.my_first_bucket.id)
# -------------------------------------------------------------
resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "tflearn-phase1-moreshwar-2026"  # must be globally unique across ALL of AWS
  tags = {
    Name        = "TFLearn Phase1 Bucket"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}
