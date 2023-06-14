resource "google_container_cluster" "cluster" {
  name     = var.gke_cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 10
  }


  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.cluster.name
  cluster    = google_container_cluster.cluster.self_link
  location   = var.region
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    disk_size_gb = 10

    machine_type = "e2-medium"
    tags         = ["gke-node", "${google_container_cluster.cluster.name}-node"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
