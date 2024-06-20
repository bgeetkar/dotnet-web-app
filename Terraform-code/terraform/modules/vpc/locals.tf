locals {
  default_tags = {
    managed_by             = "terraform"
    APPLICATION            = var.APP_NAME
    ENVIRONMENT            = var.ENVIRONMENT
  }
}