# Configuration of the Helm chart for ArgoCD
variable "argocd" {
  type = object({
    namespace : string
    chart : object({
      repository : string,
      version : string
      values_files : list(string)
    })
    applicationSet : map(object({
      name : string
      repoURL : string
      project : optional(string, "default")
    }))
  })
}