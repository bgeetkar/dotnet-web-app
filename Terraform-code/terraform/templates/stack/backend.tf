terraform {
  backend "s3" {
    bucket = "dev-project-terraform-file"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
