resource "digitalocean_vpc" "vpc" {
  name        = "${var.project_name}-${var.environment}-vpc"
  region      = var.region
  ip_range    = var.vpc_cidr
  description = "VPC for ${var.project_name} ${var.environment} environment"
}

resource "digitalocean_firewall" "firewall" {
  name = "${var.project_name}-${var.environment}-firewall"
  
  droplet_ids = var.droplet_ids
  
  dynamic "inbound_rule" {
    for_each = var.inbound_rules
    content {
      protocol          = inbound_rule.value.protocol
      port_range        = inbound_rule.value.port_range
      source_addresses  = inbound_rule.value.source_addresses
      source_droplet_ids = try(inbound_rule.value.source_droplet_ids, null)
    }
  }
  
  dynamic "outbound_rule" {
    for_each = var.outbound_rules
    content {
      protocol               = outbound_rule.value.protocol
      port_range            = outbound_rule.value.protocol != "icmp" ? outbound_rule.value.port_range : null
      destination_addresses  = outbound_rule.value.destination_addresses
    }
  }
}

resource "digitalocean_firewall" "attach_firewall" {
  count = length(var.droplet_ids) > 0 ? 1 : 0
  
  name = "${var.project_name}-${var.environment}-firewall-attach"
  droplet_ids = var.droplet_ids
  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  tags = var.tags
}