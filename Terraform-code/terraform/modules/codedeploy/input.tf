variable "APP_NAME" {
  description = "Name of the stack to be installed (ncoint-xyz)"
}

variable "ENVIRONMENT" {
  description = "Name of the stack to be installed (xyz-sandbox,preprod2)"
}

variable "SERVICE" {
  description = "Service name"
  default = "web-app"
}

variable "AWS_REGION" {
  type        = string
  default     = "ap-south-2"
  description = "aws region"
}

variable "PUBLIC_SUBNET_ID" {
  description = "A list of subnet IDs where instances will be launched."
}

variable "PRIVATE_SUBNET_ID" {
  description = "A list of subnet IDs where instances will be launched."
}

variable "VPC_ID" {
  description = "The ID of the VPC where the Auto Scaling Group will be launched."
  default = ""
}

variable "APP_PORTS" {
  default     = [80, 443]
  description = "portexposed on the docker image"
}

variable "HEALTH_CHECK_PATH" {
  default = "/index.html"
}

variable "INSTANCE_TYPE" {
  default = "t3.medium"
}

variable "CODEDEPLOY_AZ" {
  default = ""
}

variable "MIN_SIZE" {
  default = 1
}

variable "MAX_SIZE" {
  default = 1
}

variable "DESIRED_CAPACITY" {
  default = 1
}

variable "CODEDEPLOY_INAGE_ID" {
  default = "ami-0010edab22a90b68d"
}

variable "KEY_NAME" {
  default = "dev-key"
}

variable "ALB_SSL_SECURITY_POLICY" {
  default = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "ALB_SSL_CERTIFICATE_ARN" {}

variable "EBS_VOLUME_SIZE" {
  default = 50
}

variable "EBS_VOLUME_TYPE" {
  default = "gp2"
}
