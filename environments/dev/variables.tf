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
    "storage.googleapis.com"
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
