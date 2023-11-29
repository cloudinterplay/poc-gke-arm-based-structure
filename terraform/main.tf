provider "google" {
  project = var.gcp.gke_project_id
  region  = var.gcp.region
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke.master_auth.0.cluster_ca_certificate)
}
provider "kubectl" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke.master_auth.0.cluster_ca_certificate)
  load_config_file       = false
}
provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(module.gke.master_auth.0.cluster_ca_certificate)
  }
}