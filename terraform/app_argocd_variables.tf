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
  validation {
    condition = var.GITHUB_OAUTH_CLIENTID != ""
    error_message = "Github OAuth Apps clientId is empty"
  }
}
variable "GITHUB_OAUTH_CLIENTSECRET" {
  description = "Github OAuth Apps clientSecret"
  type        = string
  sensitive   = true
  validation {
    condition = var.GITHUB_OAUTH_CLIENTSECRET != ""
    error_message = "Github OAuth Apps clientSecret is empty"
  }
}