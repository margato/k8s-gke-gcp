resource "google_compute_network" "vpc" {
  name                    = "vpc-k8s"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  network                  = google_compute_network.vpc.self_link
  name                     = "subnet-1"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = var.region
  private_ip_google_access = true
}
