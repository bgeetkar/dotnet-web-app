data "aws_region" "current" {}

variable "ADDITIONAL_TAGS" {
  type = map
  default = {}
}

variable APP_NAME {
  type        = string
  default     = "ticket99"
}

variable ENVIRONMENT {
  type        = string
  default     = "staging"
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

###################################################

variable "AZ_COUNT_API" {
  default     = "1"
  description = "number of availability zones in above region"
}

variable "ECS_TASK_EXECUTION_ROLE" {
  default     = "myECcsTaskExecutionRole"
  description = "ECS task execution role name"
}

variable "APP_IMAGE_API" {
  default     = "t99-api"
  description = "docker image to run in this ECS cluster"
}

variable "IMAGE_TAG_API" {
  default = "latest"
}

variable "APP_COUNT_API" {
  default     = "1" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}

variable "HEALTH_CHECK_PATH" {
  default = "/index.html"
}

variable "FARGATE_CPU_API" {
  default     = "1024"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "FARGATE_MEMORY_API" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "MAX_CAPACITY_API" {
  default = 1
}

variable "MIN_CAPACITY_API" {
  default = 1
}

###################################################################

variable "AZ_COUNT_ADMIN_API" {
  default     = "1"
  description = "number of availability zones in above region"
}

variable "APP_IMAGE_ADMIN_API" {
  default     = "t99-api"
  description = "docker image to run in this ECS cluster"
}

variable "IMAGE_TAG_ADMIN_API" {
  default = "latest"
}

variable "APP_PORTS" {
  default = [80, 443]
  description = "Load balancer inbound rules"
}

variable "ECS_APP_PROT" {
  default     = "80"
  description = "Ecs task prot"
}

variable "APP_COUNT_ADMIN_API" {
  default     = "1" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}

variable "FARGATE_CPU_ADMIN_API" {
  default     = "1024"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "FARGATE_MEMORY_ADMIN_API" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "MAX_CAPACITY_ADMIN_API" {
  default = 1
}

variable "MIN_CAPACITY_ADMIN_API" {
  default = 1
}


variable "ALB_SSL_SECURITY_POLICY" {
  default = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "ALB_SSL_CERTIFICATE_ARN" {}
