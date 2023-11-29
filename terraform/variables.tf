# Path to Helm values files
variable "environment_dir" {
  type = string
}
# Google Cloud Platform
variable "gcp" {
  description = "The GCP common parameters"
  type = object({
    gke_project_id = string
    dns_project_id = string
    region         = string
  })
}
# VPC
variable "vpc" {
  description = "The GCP VPC parameters"
  type = object({
    network    = string
    subnetwork = string
  })
}
# GKE
variable "gke" {
  type        = any
  description = "The GKE configuration"
}
variable "ingress_nginx_external" {
  type = object({
    namespace : string
    chart : object({
      repository : string,
      version : string
      values_files : list(string)
    })
  })
}
variable "external_dns" {
  type = object({
    namespace : string
    chart : object({
      repository : string,
      version : string
      values_file : string
    })
  })
}
variable "cert_manager" {
  type = object({
    namespace : string
    chart : object({
      repository : string,
      version : string
      values_file : string
    })
  })
}
variable "clusterIssuers" {
  description = "clusterIssuers"
  # Map key is the clusterIssueName
  type = map(object({
    acmeServer              = string
    privateKeySecretRefName = string
    dnsZone                 = string
    project                 = string
  }))
}