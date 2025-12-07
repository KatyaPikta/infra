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

variable "tags" {
  type        = list(string)
  description = "Tags for resources"
  default     = []
}

variable "inbound_rules" {
  type = list(object({
    protocol          = string
    port_range        = string
    source_addresses  = list(string)
    source_droplet_ids = optional(list(string))
  }))
  default = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "icmp"
      port_range       = ""
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

variable "outbound_rules" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))
   
  default = [
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "icmp"
      port_range            = ""  # Для ICMP port_range должен быть пустым
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}