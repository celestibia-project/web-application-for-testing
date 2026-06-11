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
