resource "digitalocean_volume" "volumes" {
  count = var.volume_count
  
  name                     = "${var.project_name}-${var.environment}-vol-${count.index + 1}"
  region                   = var.region
  size                     = var.volume_size_gb
  initial_filesystem_type  = var.filesystem_type
  description              = "Storage volume ${count.index + 1} for ${var.project_name} ${var.environment}"
  
  tags = concat(["storage", "persistent"], var.tags)
}

resource "digitalocean_volume_attachment" "attachments" {
  count = var.volume_count
  
  droplet_id = var.droplet_ids[count.index % length(var.droplet_ids)]
  volume_id  = digitalocean_volume.volumes[count.index].id
}
