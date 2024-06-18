locals {
  default_tags = {
    managed_by             = "terraform"
    stack-name             = var.APP_NAME
    staging                = var.ENVIRONMENT
  }
}