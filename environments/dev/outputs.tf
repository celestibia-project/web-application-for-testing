output "enabled_apis" {
  description = "APIs requested for the Dev project."
  value       = module.project_apis.enabled_services
}

output "automation_service_account_email" {
  description = "Email address of the Dev automation service account."
  value       = module.automation_service_account.email
}
