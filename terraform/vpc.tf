resource "google_compute_network" "vpc_network" {
  depends_on              = [google_project_service.apis["compute.googleapis.com"]]
  name                    = var.vpc.network
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnetwork" {
  name                     = var.vpc.subnetwork
  stack_type               = "IPV4_IPV6"
  ipv6_access_type         = "EXTERNAL"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = var.gcp.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}
# resource "google_compute_router" "router" {
#   name    = "gke-router"
#   region  = google_compute_subnetwork.subnetwork.region
#   network = google_compute_network.vpc_network.id

#   bgp {
#     asn = 64514
#   }
# }
# resource "google_compute_router_nat" "nat" {
#   name                               = "gke-router-nat"
#   router                             = google_compute_router.router.name
#   region                             = google_compute_router.router.region
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

#   log_config {
#     enable = true
#     filter = "ERRORS_ONLY"
#   }
# }