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

variable "cluster_private_ips" {
  description = "Private IPs of all cluster nodes for internal communication"
  type        = list(string)
  default     = []
}

variable "allow_cluster_internal_traffic" {
  description = "Whether to allow all traffic between cluster nodes"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "Domain name to register"
  default     = "task3.app"
}

variable "loadbalancer_ids"{
  type        = list(string)
  description = "List of load balancer"
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