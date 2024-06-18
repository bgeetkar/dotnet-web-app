variable "CIDR_BLOCK" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "INSTANCE_TENANCY" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "ENABLE_DNS_HOSTNAMES" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = true
}

variable "ENABLE_DNS_SUPPORT" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "PUBLIC_SUBNET_CIDR_BLOCK" {
  description = "The CIDR block for the Subnet"
  default     = ["10.0.1.0/24" , "10.0.2.0/24"]

}

variable "PRIVATE_SUBNET_CIDR_BLOCK" {
  description = "The CIDR block for the Subnet"
  default     = ["10.0.3.0/24" , "10.0.4.0/24"]
}


variable "PUBLIC_SUBNET_NAME" {
  description = "Name of the public subnet"
  default     = "public-subnet"
}

variable "INTERNET_GATEWAY_NAME" {
  description = "Name of the internet gateway"
  default     = "ig"
}

variable "ROUTE_TABLE_NAME" {
  description = "Name of the Route table"
  default     = "route-tables"
}

variable "PRIVATE_SUBNET_NAME" {
  type    = string
  default = "private-subnet"
}

variable "NAT_GATEWAY_NAME" {
  description = "Name of the Nat gateway"
  default     = "ngw"
}

variable "VPC_NAME" {
  default = "vpc"
}

variable AWS_REGION {
  type        = string
  default     = "ap-south-2"
  description = "aws region"
}

variable "APP_NAME" {
  default = "ticket99"
}

variable "ENVIRONMENT" {
  description = "Name of the stack to be installed (xyz-sandbox,preprod2)"
  default = "staging"
}

variable "VPC_ID" {
  description = "The ID of the VPC where the Auto Scaling Group will be launched."
  default = ""
}