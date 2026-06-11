terraform {
  backend "gcs" {
    bucket = "celestibia-automation-bucket-remote-state"
    prefix = "terraform/dev"
  }
}
