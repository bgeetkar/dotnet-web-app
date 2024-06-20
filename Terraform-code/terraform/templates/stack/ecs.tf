module "ecs" {
  source              = "../../modules/ecs"
  ENVIRONMENT         = var.ENVIRONMENT
  APP_NAME            = var.APP_NAME
  PUBLIC_SUBNET_ID    = module.vpc_base.public_subnets_id
  PRIVATE_SUBNET_ID   = module.vpc_base.private_subnet_ids
  VPC_ID              = module.vpc_base.vpc_id
  APP_IMAGE_API       = var.APP_IMAGE_API
  IMAGE_TAG_API       = var.IMAGE_TAG_API
  APP_IMAGE_ADMIN_API = var.APP_IMAGE_ADMIN_API
  IMAGE_TAG_ADMIN_API = var.IMAGE_TAG_ADMIN_API
  ALB_SSL_CERTIFICATE_ARN = var.ALB_SSL_CERTIFICATE_ARN
}