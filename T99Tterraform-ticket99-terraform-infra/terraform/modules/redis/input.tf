// ELASTICCACHE Instance Variables

variable "ENABLE_REDIS" {
  type = bool
  default = true
}

variable "APP_NAME" {
  default = "ticket99"
}

variable "STACK_REGION" {
  default = "ap-south-2"
}

variable "ENVIRONMENT" {
  description = "Name of the stack to be installed (xyz-sandbox,preprod2)"
  default = "staging"
}

variable "VPC_ID" {
  default = ""
}

variable "ENGINE_VERSION" {
  default = "3.2.6"
}

variable "REDIS_PORT" {
  default = "6379"
}

variable "ELASTICACHE_INSTANCE_TYPE" {
  default = "cache.m4.large"
}

variable "NR_CACHE_NODES" {
  default = 2
}

variable "PARAMETER_GROUP_NAME" {
  default = "custom-redis-param-group"
}

variable "MAINTENANCE_WINDOW" {
  # SUN 01:00AM-02:00AM ET
  default = "sun:05:00-sun:06:00"
}

variable "ELASTICACHE_BACKUP_RENTENTION" {
  default = 30
}

variable "ELASTICACHE_AVAILABILITY_ZONES" {
  description = "Availability zone to use by Elasticache replica"
  default = ""
}


variable "USE_REDIS_TRANSIT_ENCRYPTION" {
  default = false
}

variable "USE_REDIS_AT_REST_ENCRYPTION" {
  default = false
}

variable "ELASTICACHE_SG_INBOUND_DESCRIPTION" {
  type = map
  default = {}
}

variable "PUBLIC_SUBNET_ID" {
  description = "A list of subnet IDs where instances will be launched."
}

variable "PRIVATE_SUBNET_ID" {
  description = "A list of subnet IDs where instances will be launched."
}

variable "REDIS_FAMILY" {
  default = "redis7"
}