output "vpc_id" {
  value = digitalocean_vpc.vpc.id
}

output "vpc_ip_range" {
  value = digitalocean_vpc.vpc.ip_range
}

output "firewall_id" {
  value = digitalocean_firewall.firewall.id
}