# Dedicated least-privilege service account for GKE nodes
resource "google_service_account" "gke_nodes" {
  account_id   = "${var.cluster_name}-node-sa"
  display_name = "GKE Node Pool Service Account"
  project      = var.project_id
}

# IAM bindings required for GKE nodes to function and log/monitor correctly
locals {
  gke_roles = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/storage.objectViewer"
  ]
}

resource "google_project_iam_member" "gke_nodes_roles" {
  for_each = toset(local.gke_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# GKE Standard Cluster definition
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
  project  = var.project_id

  network    = var.network
  subnetwork = var.subnetwork

  # We remove the default node pool to separate node configurations
  remove_default_node_pool = true
  initial_node_count       = 1

  # Required for modern VPC-native IP routing
  ip_allocation_policy {}

  # Prevent resource destruction issues during updates
  lifecycle {
    ignore_changes = [
      node_config
    ]
  }
}

# Custom GKE Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.zone
  project    = var.project_id
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    service_account = google_service_account.gke_nodes.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    # Security best practice: disable legacy metadata APIs
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
