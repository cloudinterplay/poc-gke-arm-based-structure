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
variable "github_oauth_clientId" {
  description = "Github OAuth Apps clientId"
  type        = string
  sensitive   = true
  validation {
    condition = var.github_oauth_clientId != ""
    error_message = "Github OAuth Apps clientId is empty"
  }
}
variable "github_oauth_clientSecret" {
  description = "Github OAuth Apps clientSecret"
  type        = string
  sensitive   = true
  validation {
    condition = var.github_oauth_clientSecret != ""
    error_message = "Github OAuth Apps clientSecret is empty"
  }
}