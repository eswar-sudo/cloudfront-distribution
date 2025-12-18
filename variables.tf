variable "region" {
  type = string
}

variable "enabled" {
  type    = bool
  default = true
}

variable "comment" {
  type    = string
  default = null
}

variable "default_root_object" {
  type    = string
  default = null
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "origins" {
  description = "Origins map passed to CloudFront module"
  type        = any
}

variable "default_cache_behavior" {
  type = object({
    target_origin_id       = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    viewer_protocol_policy = string
    query_string           = bool
    cookies_forward        = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number
  })
}

variable "acm_certificate_arn" {
  type = string
}

variable "ssl_support_method" {
  type    = string
  default = "sni-only"
}

variable "minimum_protocol_version" {
  type    = string
  default = "TLSv1.2_2021"
}

variable "geo_restriction_type" {
  type    = string
  default = "none"
}

variable "geo_restriction_locations" {
  type    = list(string)
  default = []
}
