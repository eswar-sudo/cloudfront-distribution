# --------------------
# GLOBAL
# --------------------
region              = "us-east-1"
enabled             = true
#is_ipv6_enabled     = true
comment             = "CloudFront distribution"
default_root_object = "index.html"
price_class         = "PriceClass_100"

aliases = ["app.example.com"]

tags = {
  Environment = "dev"
  Project     = "cloudfront-demo"
}

# --------------------
# ORIGINS
# --------------------

# --------------------
# ORIGINS (ALL TYPES)
# --------------------
origins = [

  #  S3 ORIGIN
  {
    origin_id   = "s3-origin"
    domain_name = "cloudfront-test-spacelift.us-east-1.amazonaws.com"
    origin_type = "s3"

    s3_origin_config = {
      origin_access_identity = "origin-access-identity/cloudfront/E123"
    }
  },

  # VPC / ALB ORIGIN
  {
    origin_id   = "vpc-origin"
    domain_name = "internal-alb-123.us-east-1.elb.amazonaws.com"
    origin_type = "vpc"

    custom_origin_config = {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  },

  #  API GATEWAY ORIGIN
  {
    origin_id   = "apigw-origin"
    domain_name = "abcd1234.execute-api.us-east-1.amazonaws.com"
    origin_type = "apigw"

    custom_origin_config = {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  },

   #  Elemental MediaPackage
  {
  origin_id   = "mediapackage-origin"
  domain_name = "abcd.mediapackage.us-east-1.amazonaws.com"
  origin_type = "mediapackage"

  custom_origin_config = {
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "https-only"
    origin_ssl_protocols   = ["TLSv1.2"]
  }
 },



  #  ELASTIC LOAD BALANCER ORIGIN
  {
    origin_id   = "elb-origin"
    domain_name = "nlb-xx-xx.us-east-2.amazonaws.com"
    origin_type = "custom"

    custom_origin_config = {
      http_port              = 8080
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  },

  #  EXTERNAL / ON-PREM ORIGIN
  {
    origin_id   = "external-origin"
    domain_name = "app.company.com"
    origin_type = "external"

    custom_origin_config = {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
]


# --------------------
# CACHE BEHAVIOR
# --------------------
default_cache_behavior = {
allowed_methods        = ["GET", "HEAD", "OPTIONS"]
cached_methods         = ["GET", "HEAD"]
target_origin_id       = "s3-origin"
viewer_protocol_policy = "redirect-to-https"

query_string = true
cookies_forward      = "all"

min_ttl     = 0
default_ttl = 3600
max_ttl     = 86400
}

# --------------------
# TLS / ACM
# --------------------
acm_certificate_arn      = "arn:aws:acm:us-east-1:123456789012:certificate/abcd-1234"
ssl_support_method       = "sni-only"
minimum_protocol_version = "TLSv1.2_2021"

# --------------------
# GEO RESTRICTION
# --------------------
geo_restriction_type      = "none"
geo_restriction_locations = []
