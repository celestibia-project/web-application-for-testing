variable "project_id" {
  description = "The GCP project ID to deploy the GKE cluster."
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "internal-cluster"
}

variable "zone" {
  description = "The zone to deploy the GKE cluster."
  type        = string
  default     = "europe-west2-c"
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "The machine type for GKE nodes."
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "The size of the node VM boot disks in GB."
  type        = number
  default     = 50
}

variable "disk_type" {
  description = "The type of disk to use for nodes (e.g. pd-standard, pd-balanced)."
  type        = string
  default     = "pd-standard"
}

variable "network" {
  description = "The VPC network to host the cluster."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster."
  type        = string
  default     = "default"
}
