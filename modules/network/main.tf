resource "digitalocean_vpc" "vpc" {
  name        = "${var.project_name}-${var.environment}-vpc"
  region      = var.region
  ip_range    = var.vpc_cidr
  description = "VPC for ${var.project_name} ${var.environment} environment"
}

resource "digitalocean_firewall" "firewall" {
  name = "${var.project_name}-${var.environment}-firewall"
  droplet_ids = var.droplet_workers_ids

  dynamic "inbound_rule" {
    for_each = var.inbound_rules_public
    content {
      protocol          = inbound_rule.value.protocol
      port_range        = inbound_rule.value.port_range
      source_addresses  = inbound_rule.value.source_addresses
      source_droplet_ids = try(inbound_rule.value.source_droplet_ids, null)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_rules_public
    content {
      protocol               = outbound_rule.value.protocol
      port_range             = outbound_rule.value.protocol != "icmp" ? outbound_rule.value.port_range : null
      destination_addresses  = outbound_rule.value.destination_addresses
    }
  }
}

resource "digitalocean_firewall" "attach_firewall" {
   
  name = "${var.project_name}-${var.environment}-firewall-attach"
  droplet_ids = var.droplet_ids

  dynamic "inbound_rule" {
    for_each = var.inbound_rules_private
    content {
      protocol           = inbound_rule.value.protocol
      port_range         = inbound_rule.value.port_range
      source_addresses   = inbound_rule.value.source_addresses
      source_droplet_ids = try(inbound_rule.value.source_droplet_ids, null)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_rules_private
    content {
      protocol               = outbound_rule.value.protocol
      port_range             = outbound_rule.value.protocol != "icmp" ? outbound_rule.value.port_range : null
      destination_addresses  = outbound_rule.value.destination_addresses
    }
  }

  tags = var.tags
}