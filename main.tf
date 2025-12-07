module "network" {
  source = "./modules/network"
  
  project_name = var.project_name
  environment  = terraform.workspace
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  
  inbound_rules = var.inbound_rules
  droplet_ids   = module.compute.all_droplet_ids
}

module "compute" {
  source = "./modules/compute"
  
  project_name = var.project_name
  environment  = terraform.workspace
  region       = var.region
  vpc_id       = module.network.vpc_id
  
  control_plane_count = var.control_plane_count
  worker_count        = var.worker_count
  control_plane_size  = var.control_plane_size
  worker_size         = var.worker_size
  
  ssh_public_key_path = var.ssh_public_key_path
}

module "persistence" {
  source = "./modules/persistence"
  
  project_name = var.project_name
  environment  = terraform.workspace
  region       = var.region
  
  volume_count   = var.volume_count
  volume_size_gb = var.volume_size_gb
  droplet_ids    = module.compute.worker_ids
}