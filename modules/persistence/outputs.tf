output "volume_ids" {
  value = digitalocean_volume.volumes[*].id
}

output "volume_names" {
  value = digitalocean_volume.volumes[*].name
}
