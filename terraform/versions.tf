terraform {
  required_version = ">=0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.47"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.14"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
  backend "gcs" {}
}