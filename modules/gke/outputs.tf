output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "The Kubernetes control plane endpoint."
  value       = google_container_cluster.primary.endpoint
}

output "ca_certificate" {
  description = "The public CA certificate used to communicate with the cluster."
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}
