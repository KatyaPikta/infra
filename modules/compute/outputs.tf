output "control_plane_ids" {
  value = digitalocean_droplet.control_plane[*].id
}

output "worker_ids" {
  value = digitalocean_droplet.workers[*].id
}

output "all_droplet_ids" {
  value = concat(
    digitalocean_droplet.control_plane[*].id,
    digitalocean_droplet.workers[*].id
  )
}

output "control_plane_ips" {
  value = digitalocean_droplet.control_plane[*].ipv4_address
}

output "worker_ips" {
  value = digitalocean_droplet.workers[*].ipv4_address
}

output "all_ips" {
  value = concat(
    digitalocean_droplet.control_plane[*].ipv4_address,
    digitalocean_droplet.workers[*].ipv4_address
  )
}

output "private_ips" {
  value = concat(
    digitalocean_droplet.control_plane[*].ipv4_address_private,
    digitalocean_droplet.workers[*].ipv4_address_private
  )
}

output "ssh_key_fingerprint" {
  value = digitalocean_ssh_key.ssh_key.fingerprint
}