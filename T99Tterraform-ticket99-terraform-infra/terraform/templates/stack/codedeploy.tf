module "codedeploy" {
  source              = "../../modules/codedeploy"
  ENVIRONMENT         = var.ENVIRONMENT
  APP_NAME            = var.APP_NAME
  PUBLIC_SUBNET_ID    = module.vpc_base.public_subnets_id
  PRIVATE_SUBNET_ID   = module.vpc_base.private_subnet_ids
  VPC_ID              = module.vpc_base.vpc_id
  CODEDEPLOY_INAGE_ID = var.CODEDEPLOY_INAGE_ID
  SERVICE             = var.SERVICE
  APP_PORTS           = var.APP_PORTS
  ALB_SSL_CERTIFICATE_ARN = var.ALB_SSL_CERTIFICATE_ARN
  EBS_VOLUME_SIZE = var.EBS_VOLUME_SIZE
  EBS_VOLUME_TYPE = var.EBS_VOLUME_TYPE
}