output "route53_zone_name" {
  value = module.zones.route53_zone_name["demo.jumisa.io"]
}

output "route53_zone_name_servers" {
  value = module.zones.route53_zone_name_servers["demo.jumisa.io"]
}
output "count_ns" {
  value = length(module.zones.route53_zone_name_servers["demo.jumisa.io"])
}

output "zero_th" {
  value = module.zones.route53_zone_name_servers["demo.jumisa.io"][0]
}