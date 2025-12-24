resource "digitalocean_ssh_key" "ssh_key" {
  name       = "${var.project_name}-${var.environment}-ssh-key"
  public_key = file(var.ssh_public_key_path)
}

resource "digitalocean_droplet" "control_plane" {
  count = var.control_plane_count
  
  name     = "master"
  image    = var.os_image
  region   = var.region
  size     = var.control_plane_size
  ssh_keys = [digitalocean_ssh_key.ssh_key.fingerprint]
  vpc_uuid = var.vpc_id
  tags     = concat(["control-plane", "k8s-master"], var.tags)
  
  monitoring = var.enable_monitoring
  
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(replace(var.ssh_public_key_path, ".pub", ""))
    host        = self.ipv4_address
  }
  
  user_data = templatefile("${path.module}/templates/cloud-init.yaml", {
    node_type    = "control-plane"
    environment  = var.environment
    hostname     = "${var.project_name}-${var.environment}-cp-${count.index + 1}"
  })
}

resource "digitalocean_droplet" "workers" {
  count = var.worker_count
  
  name     = "worker${count.index + 1}"
  image    = var.os_image
  region   = var.region
  size     = var.worker_size
  ssh_keys = [digitalocean_ssh_key.ssh_key.fingerprint]
  vpc_uuid = var.vpc_id
  tags     = concat(["worker", "k8s-node"], var.tags)
  
  monitoring = var.enable_monitoring
  
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(replace(var.ssh_public_key_path, ".pub", ""))
    host        = self.ipv4_address
  }
  
  user_data = templatefile("${path.module}/templates/cloud-init.yaml", {
    node_type    = "worker"
    environment  = var.environment
    hostname     = "${var.project_name}-${var.environment}-worker-${count.index + 1}"
  })
}