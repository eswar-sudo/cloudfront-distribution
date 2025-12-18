resource "aws_cloudfront_distribution" "this" {
  enabled             = var.enabled
  comment             = var.comment
  price_class         = var.price_class
  aliases             = var.aliases
  default_root_object = var.default_root_object

  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      origin_path = lookup(origin.value, "origin_path", null)

      dynamic "s3_origin_config" {
        for_each = origin.value.origin_type == "s3" ? [1] : []
        content {
          origin_access_identity = origin.value.s3_origin_config.origin_access_identity
        }
      }

      dynamic "custom_origin_config" {
        for_each = origin.value.origin_type != "s3" ? [1] : []
        content {
          http_port              = origin.value.custom_origin_config.http_port
          https_port             = origin.value.custom_origin_config.https_port
          origin_protocol_policy = origin.value.custom_origin_config.origin_protocol_policy
          origin_ssl_protocols   = origin.value.custom_origin_config.origin_ssl_protocols
        }
      }

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_headers", {})
        content {
          name  = custom_header.key
          value = custom_header.value
        }
      }
    }
  }

  default_cache_behavior {
    target_origin_id       = var.default_cache_behavior.target_origin_id
    allowed_methods        = var.default_cache_behavior.allowed_methods
    cached_methods         = var.default_cache_behavior.cached_methods
    viewer_protocol_policy = var.default_cache_behavior.viewer_protocol_policy
    min_ttl     = var.default_cache_behavior.min_ttl
    default_ttl = var.default_cache_behavior.default_ttl
    max_ttl     = var.default_cache_behavior.max_ttl

    forwarded_values {
      query_string = var.default_cache_behavior.query_string
      cookies {
        forward = var.default_cache_behavior.cookies_forward
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = var.ssl_support_method
    minimum_protocol_version = var.minimum_protocol_version
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type != null ? var.geo_restriction_type : "none"
      locations        = var.geo_restriction_type == "none" ? [] : var.geo_restriction_locations
    }
  }

  tags = var.tags
}
