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
variable "GITHUB_OAUTH_CLIENTID" {
  description = "Github OAuth Apps clientId"
  type        = string
  sensitive   = true
}
variable "GITHUB_OAUTH_CLIENTSECRET" {
  description = "Github OAuth Apps clientSecret"
  type        = string
  sensitive   = true
}