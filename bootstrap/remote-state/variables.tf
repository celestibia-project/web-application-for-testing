variable "project_id" {
  description = "GCP project ID where the Terraform state bucket will be created."
  type        = string
}

variable "region" {
  description = "Default GCP region."
  type        = string
  default     = "us-central1"
}

variable "state_bucket_name" {
  description = "Name of the GCS bucket used for Terraform remote state."
  type        = string
  default     = "celestibia-automation-bucket-remote-state"
}

variable "state_bucket_location" {
  description = "GCS bucket location for Terraform remote state."
  type        = string
  default     = "US"
}

variable "labels" {
  description = "Labels applied to bootstrap resources."
  type        = map(string)
  default = {
    managed_by  = "terraform"
    environment = "bootstrap"
  }
}

