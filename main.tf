terraform {
  backend "s3" {
    bucket       = "demo-bucket-903936907495-us-east-2-an"
    key          = "site/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.37"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "site" {
  bucket           = format("ibrahim-site-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  bucket_namespace = "account-regional"
}

output "bucket_name" {
  value = aws_s3_bucket.site.bucket
}
