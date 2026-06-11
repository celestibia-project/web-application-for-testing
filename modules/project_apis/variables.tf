variable "project_id" {
  description = "GCP project ID where APIs should be enabled."
  type        = string
}

variable "services" {
  description = "Set of service APIs to enable."
  type        = set(string)
}

