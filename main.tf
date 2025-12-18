terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "cdn" {
  source = "./Module/cloudfront-distribution"

  enabled             = var.enabled
  comment             = var.comment
  default_root_object = var.default_root_object
  price_class         = var.price_class
  aliases             = var.aliases
  tags                = var.tags

  origins = var.origins

  # ✅ THIS IS THE KEY FIX
  default_cache_behavior = var.default_cache_behavior

  acm_certificate_arn      = var.acm_certificate_arn
  ssl_support_method       = var.ssl_support_method
  minimum_protocol_version = var.minimum_protocol_version

  geo_restriction_type      = var.geo_restriction_type
  geo_restriction_locations = var.geo_restriction_locations
}
