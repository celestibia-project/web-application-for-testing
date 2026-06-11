output "enabled_services" {
  description = "Services managed by this module."
  value       = keys(google_project_service.this)
}

