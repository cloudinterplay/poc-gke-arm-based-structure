module "cert_manager" {
  depends_on = [
    module.gke
  ]
  source = "git::https://github.com/tf-modules-gcp/terraform-gcp-gke-cert-manager.git//modules/cert-manager?ref=0.0.1"
  # Local Development
  # source          = "../../../tf-modules-gcp/terraform-gcp-gke-cert-manager/modules/cert-manager"
  environment_dir = var.environment_dir
  sa_sufix        = var.gke.cluster.name
  gke_project_id  = var.gcp.gke_project_id
  dns_project_id  = var.gcp.dns_project_id
  helm_config     = var.cert_manager
  clusterIssuers  = var.clusterIssuers
}