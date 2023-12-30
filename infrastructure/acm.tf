# =============================================== #
# SSL Cert for domain
# Signed by AWS 
# Validation method: Route53 DNS 
# DomainName: "${var.r53record.sub_domain}.${var.r53record.base_domain}"
# SAN: "*.${var.r53record.sub_domain}.${var.r53record.base_domain}"
# =============================================== #
module "acm" {
  depends_on = [ module.zones, cloudflare_record.main]
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = module.zones.route53_zone_name["${local.demo_domain}"]
  zone_id      = module.zones.route53_zone_zone_id["${local.demo_domain}"]
  
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${local.demo_domain}"
  ]

  wait_for_validation = true

  tags = merge({ Name = "${local.demo_domain}" },var.tags)
}