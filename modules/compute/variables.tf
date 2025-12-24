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

variable "vpc_id" {
  type        = string
  description = "VPC ID to place droplets in"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key"
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
