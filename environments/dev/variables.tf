variable "project_id" {
  description = "GCP project ID for Dev resources."
  type        = string
}

variable "region" {
  description = "Default GCP region for Dev resources."
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "Dev"
}

variable "required_apis" {
  description = "GCP APIs required by the Dev foundation."
  type        = set(string)
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "storage.googleapis.com",
    "container.googleapis.com"
  ]
}

variable "labels" {
  description = "Common labels applied to supported Dev resources."
  type        = map(string)
  default = {
    managed_by  = "terraform"
    environment = "dev"
  }
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "internal-cluster"
}

variable "gke_zone" {
  description = "The zone to deploy the GKE cluster."
  type        = string
  default     = "europe-west2-c"
}

variable "gke_node_count" {
  description = "The number of nodes in the GKE node pool."
  type        = number
  default     = 2
}

variable "gke_machine_type" {
  description = "The machine type for GKE nodes."
  type        = string
  default     = "e2-medium"
}

variable "gke_disk_size_gb" {
  description = "The boot disk size for GKE nodes in GB."
  type        = number
  default     = 50
}

variable "gke_disk_type" {
  description = "The boot disk type for GKE nodes."
  type        = string
  default     = "pd-standard"
}
