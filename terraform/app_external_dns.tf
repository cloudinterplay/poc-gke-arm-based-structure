module "external_dns" {
  depends_on = [
    module.gke
  ]
  source = "git::https://github.com/tf-modules-gcp/terraform-gcp-gke-external-dns.git//modules/external-dns?ref=0.0.1"
  # Local Development
  # source          = "../../../tf-modules-gcp/terraform-gcp-gke-external-dns/modules/external-dns"
  environment_dir = var.environment_dir
  sa_sufix        = var.gke.cluster.name
  gke_project_id  = var.gcp.gke_project_id
  dns_project_id  = var.gcp.dns_project_id
  helm_config     = var.external_dns
}