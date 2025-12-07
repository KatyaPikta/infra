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

variable "filesystem_type" {
  type        = string
  description = "Filesystem type"
  default     = "ext4"
}

variable "droplet_ids" {
  type        = list(string)
  description = "List of droplet IDs to attach volumes to"
  default     = []
}

variable "tags" {
  type        = list(string)
  description = "Tags for resources"
  default     = []
}

variable "create_spaces_bucket" {
  type        = bool
  description = "Create Spaces bucket for backups"
  default     = false
}

variable "backup_retention_days" {
  type        = number
  description = "Days to retain backups"
  default     = 30
}