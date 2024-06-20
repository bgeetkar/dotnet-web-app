module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "5.2.0"
  cidr                 = var.CIDR_BLOCK
  instance_tenancy     = var.INSTANCE_TENANCY
  enable_dns_hostnames = var.ENABLE_DNS_HOSTNAMES
  enable_dns_support   = var.ENABLE_DNS_SUPPORT
  public_subnets       = var.PUBLIC_SUBNET_CIDR_BLOCK
#  private_subnets      = var.PRIVATE_SUBNET_CIDR_BLOCK
  enable_nat_gateway   = false
  azs                  = data.aws_availability_zones.available.names
  vpc_tags = {
    Name = "${var.APP_NAME}-${var.ENVIRONMENT}-${var.VPC_NAME}"
  }
  public_subnet_tags = {
    Name = "${var.APP_NAME}-${var.ENVIRONMENT}-${var.PUBLIC_SUBNET_NAME}"
  }
  igw_tags = {
    Name = "${var.APP_NAME}-${var.ENVIRONMENT}-${var.INTERNET_GATEWAY_NAME}"
  }
  public_route_table_tags = {
    Name = "${var.APP_NAME}-${var.ENVIRONMENT}-${var.ROUTE_TABLE_NAME}"
  }
  private_subnet_tags = {
    Name = "${var.APP_NAME}-${var.ENVIRONMENT}-${var.PRIVATE_SUBNET_NAME}"
  }
  nat_gateway_tags = {
    Name = "${var.APP_NAME}-${var.ENVIRONMENT}-${var.NAT_GATEWAY_NAME}"
  }
 tags = local.default_tags
}


data "aws_availability_zones" "available" {
  state = "available"
}
