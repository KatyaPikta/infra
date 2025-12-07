variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  description = "DigitalOcean region"
  default     = "fra1"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "staging"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "inbound_rules" {
  type = list(object({
    protocol          = string
    port_range        = string
    source_addresses  = list(string)
    source_droplet_ids = optional(list(string))
  }))
  default = []
}

variable "outbound_rules" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))
  default = []
}

variable "control_plane_count" {
  type        = number
  description = "Number of control plane nodes"
  default     = 1
}

variable "worker_count" {
  type        = number
  description = "Number of worker nodes"
  default     = 2
}

variable "control_plane_size" {
  type        = string
  description = "Droplet size for control plane"
  default     = "s-2vcpu-4gb"
}

variable "worker_size" {
  type        = string
  description = "Droplet size for workers"
  default     = "s-2vcpu-4gb"
}

variable "os_image" {
  type        = string
  description = "OS image slug"
  default     = "ubuntu-22-04-x64"
}

variable "tags" {
  type        = list(string)
  description = "Tags for droplets"
  default     = []
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable droplet monitoring"
  default     = false
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key"
}

variable "volume_count" {
  type        = number
  description = "Number of volumes to create"
  default     = 0
}

variable "volume_size_gb" {
  type        = number
  description = "Size of each volume in GB"
  default     = 50
}
