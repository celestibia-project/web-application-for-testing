variable "project_id" {
  description = "GCP project ID where the service account should be created."
  type        = string
}

variable "account_id" {
  description = "Service account ID."
  type        = string
}

variable "display_name" {
  description = "Human-readable service account display name."
  type        = string
}

variable "description" {
  description = "Service account description."
  type        = string
  default     = null
}

