variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment (staging/production)"
}

variable "region" {
  type        = string
  description = "DigitalOcean region"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "droplet_ids" {
  type        = list(string)
  description = "List of droplet IDs to attach to firewall"
  default     = []
}

variable "droplet_workers_ids" {
  type        = list(string)
  description = "List of droplet workers IDs to attach to firewall"
  default     = []
}

variable "tags" {
  type        = list(string)
  description = "Tags for resources"
  default     = []
}

variable "inbound_rules_public" {
  type = list(object({
    protocol           = string
    port_range         = string
    source_addresses   = list(string)
    source_droplet_ids = optional(list(string))
  }))

}


variable "outbound_rules_public" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))

}

variable "inbound_rules_private" {
  type = list(object({
    protocol           = string
    port_range         = string
    source_addresses   = list(string)
    source_droplet_ids = optional(list(string))
  }))
}

variable "outbound_rules_private" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))
}
