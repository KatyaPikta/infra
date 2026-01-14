module "network" {
  source = "./modules/network"

  project_name = var.project_name
  environment  = terraform.workspace
  region       = var.region
  vpc_cidr     = var.vpc_cidr

  inbound_rules_public   = var.inbound_rules_public
  inbound_rules_private  = var.inbound_rules_private
  outbound_rules_public  = var.outbound_rules_public
  outbound_rules_private = var.outbound_rules_private

  droplet_ids         = module.compute.all_droplet_ids # how this work, when both modules depend on each other?
  droplet_workers_ids = module.compute.worker_ids

}

module "compute" {
  source = "./modules/compute"

  project_name = var.project_name
  environment  = terraform.workspace
  region       = var.region
  vpc_id       = module.network.vpc_id # how this work, when both modules depend on each other?

  control_plane_count = var.control_plane_count
  worker_count        = var.worker_count
  control_plane_size  = var.control_plane_size
  worker_size         = var.worker_size

  ssh_public_key_path = var.ssh_public_key_path
}
