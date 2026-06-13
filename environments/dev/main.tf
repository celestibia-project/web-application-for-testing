module "project_apis" {
  source = "../../modules/project_apis"

  project_id = var.project_id
  services   = var.required_apis
}

module "automation_service_account" {
  source = "../../modules/service_account"

  project_id   = var.project_id
  account_id   = "automation-dev"
  display_name = "Automation Dev Service Account"
  description  = "Service account for Dev automation workloads."
}

module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  cluster_name = var.gke_cluster_name
  zone         = var.gke_zone
  node_count   = var.gke_node_count
  machine_type = var.gke_machine_type
  disk_size_gb = var.gke_disk_size_gb
  disk_type    = var.gke_disk_type

  depends_on = [module.project_apis]
}
