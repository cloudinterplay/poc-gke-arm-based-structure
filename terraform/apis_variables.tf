variable "google_cloud_services" {
  type = set(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com"
  ]
}