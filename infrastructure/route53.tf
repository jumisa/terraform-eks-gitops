# =============================================== #
# Hosted Zone
# Public Hosted zone for the 
# sub domain ${var.r53record.sub_domain} and
# base domain ${var.r53record.base_domain}
# Allows the inbound from VPC private subnets
# =============================================== #
locals {
  demo_domain = "${var.r53record.sub_domain}.${var.r53record.base_domain}"
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "${local.demo_domain}" = {
      comment = "${local.demo_domain} (demo)"
      tags = var.tags
    }
  }

  tags = var.tags
}

# =============================================== #
# adding NS to cloudflare
# Base Domain is on CloudFlare
# This resource is going to attach the AWS NS 
# entried of Hosted Zone to CloudFlare
# =============================================== #
data "cloudflare_zone" "main" {
  name = var.r53record.base_domain
}

resource "cloudflare_record" "main" {
  count     = 4
  zone_id   = data.cloudflare_zone.main.id
  name      = var.r53record.sub_domain
  value     = module.zones.route53_zone_name_servers["${local.demo_domain}"][count.index]
  type      = "NS"
  proxied   = false
}
