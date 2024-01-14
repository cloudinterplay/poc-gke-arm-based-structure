resource "kubernetes_namespace_v1" "argocd" {
  depends_on = [
    module.gke
  ]
  metadata {
    name = var.argocd.namespace
  }
}
resource "kubernetes_secret_v1" "github_oauth" {
  metadata {
    namespace = kubernetes_namespace_v1.argocd.id
    name      = "github-oauth"
    labels = {
      "app.kubernetes.io/part-of" = "argocd"
    }
  }
  data = {
    clientId     = var.GITHUB_OAUTH_CLIENTID
    clientSecret = var.GITHUB_OAUTH_CLIENTSECRET
  }
  type = "Opaque"
}
resource "helm_release" "kubernetes_argocd" {
  depends_on = [
    kubernetes_namespace_v1.argocd
  ]
  name       = "argocd"
  repository = var.argocd.chart.repository
  chart      = "argo-cd"
  version    = var.argocd.chart.version
  namespace  = kubernetes_namespace_v1.argocd.id
  timeout    = 600

  values = [for s in var.argocd.chart.values_files : file("${local.environment_dir}/${s}")]
}
# Application Set for Infrastructure components
resource "kubectl_manifest" "app_set_infra" {
  depends_on      = [helm_release.kubernetes_argocd]
  for_each        = var.argocd.applicationSet
  validate_schema = false
  yaml_body       = <<-YAML
    ---
    apiVersion: argoproj.io/v1alpha1
    kind: ApplicationSet
    metadata:
      name: ${each.value.name}
      namespace: ${kubernetes_namespace_v1.argocd.metadata[0].name}
    spec:
      generators:
      - git:
          repoURL: ${each.value.repoURL}
          revision: ${var.gke.cluster.name}
          directories:
          - path: hosts/*
            exclude: true
          - path: '*/*'
      template:
        metadata:
          name: '{{path[1]}}'
        spec:
          project: ${each.value.project}
          source:
            path: '{{ path }}'
            repoURL: ${each.value.repoURL}
            targetRevision: ${var.gke.cluster.name}
            helm:
              valueFiles:
              - values.yaml
              - /hosts/${var.gke.cluster.name}/{{ path }}/values.yaml
          destination:
            server: https://kubernetes.default.svc
            namespace: '{{ path[0] }}'
          syncPolicy:
            automated:
              selfHeal: true
              prune: true
            syncOptions:
            - CreateNamespace=true
            - ServerSideApply=true
  YAML
}