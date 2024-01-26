module "gke" {
  depends_on = [
    google_compute_subnetwork.subnetwork
  ]
  source = "git::https://github.com/tf-modules-gcp/terraform-gcp-gke-cluster.git//modules/cluster?ref=0.1.0"
  # Local Development
  # source = "../../../tf-modules-gcp/terraform-gcp-gke-cluster/modules/cluster"
  cluster = merge(
    {
      project    = var.gcp.gke_project_id,
      network    = google_compute_network.vpc_network.id,
      subnetwork = google_compute_subnetwork.subnetwork.id
    },
    var.gke.cluster
  )
  node_pools = var.gke.node_pools
}