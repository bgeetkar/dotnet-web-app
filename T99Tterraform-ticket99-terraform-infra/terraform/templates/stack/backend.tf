terraform {
  backend "s3" {
    bucket = "paltform-project-terraform-file"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}