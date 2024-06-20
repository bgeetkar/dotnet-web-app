variable "APP_NAME" {
  description = "Name of the stack to be installed (ncoint-xyz)"
}

variable "ENVIRONMENT" {
  description = "Name of the stack to be installed (xyz-sandbox,preprod2)"
}

variable "AWS_REGION" {
  type        = string
  default     = "ap-south-2"
  description = "aws region"
}

variable "PUBLIC_SUBNET_ID" {
  type = string
  description = "A list of subnet IDs where instances will be launched."
}

variable "PRIVATE_SUBNET_ID" {
  description = "A list of subnet IDs where instances will be launched."
}

variable "VPC_ID" {
  description = "The ID of the VPC where the Auto Scaling Group will be launched."
  default = ""
}

variable "ENGINE_TYPE" {
  default = "RabbitMQ"
}

variable "RABBITMQ_ENGINE_VERSION" {
  default = "3.11.28"
}

variable "HOST_INSTANCE_TYPE" {
  default = "mq.t3.micro"
}

variable "RABBIT_MQ_USERNAME" {
  type        = string
  description = "Username for RabbitMQ"
  sensitive   = true
}

variable "RABBIT_MQ_PASSWORD" {
  type        = string
  description = "password for RabbitMQ"
  sensitive   = true
}

variable "INSTANE_SG" {
  description = "here is instance sg"
}

variable "ECS_APPLICATION" {
  description = "here is ecs app sg"
}

variable "ENABLE_RABBITMQ" {
  default = false
}