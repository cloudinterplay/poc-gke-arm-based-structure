resource "kubernetes_namespace" "ingress_nginx" {
  depends_on = [
    module.gke
  ]
  metadata {
    annotations = {
      name = var.ingress_nginx_external.namespace
    }

    name = var.ingress_nginx_external.namespace
  }
}

resource "helm_release" "kubernetes_ingress_nginx" {
  depends_on = [kubernetes_namespace.ingress_nginx]
  name       = "ingress-nginx"

  repository = var.ingress_nginx_external.chart.repository
  chart      = "ingress-nginx"
  version    = var.ingress_nginx_external.chart.version
  namespace  = kubernetes_namespace.ingress_nginx.id
  timeout    = 600

  values = [for s in var.ingress_nginx_external.chart.values_files : file("${local.environment_dir}/${s}")]
}
