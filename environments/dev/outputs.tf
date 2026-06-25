output "enabled_apis" {
  description = "APIs requested for the Dev project."
  value       = module.project_apis.enabled_services
}

output "automation_service_account_email" {
  description = "Email address of the Dev automation service account."
  value       = module.automation_service_account.email
}

output "gke_cluster_name" {
  description = "The name of the GKE cluster."
  value       = module.gke.cluster_name
}

output "gke_endpoint" {
  description = "The Kubernetes control plane endpoint."
  value       = module.gke.endpoint
}

output "gke_ca_certificate" {
  description = "The public CA certificate used to communicate with the cluster."
  value       = module.gke.ca_certificate
  sensitive   = true
}
