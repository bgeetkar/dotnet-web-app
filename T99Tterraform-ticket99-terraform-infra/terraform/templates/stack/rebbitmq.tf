module "rebbitmq" {
  source                  = "../../modules/rabbitmq"
  ENABLE_RABBITMQ         = var.ENABLE_RABBITMQ
  ENVIRONMENT             = var.ENVIRONMENT
  APP_NAME                = var.APP_NAME
  PUBLIC_SUBNET_ID        = module.vpc_base.public_subnets_id[0]
  PRIVATE_SUBNET_ID       = module.vpc_base.private_subnet_ids
  VPC_ID                  = module.vpc_base.vpc_id
  RABBITMQ_ENGINE_VERSION = var.RABBITMQ_ENGINE_VERSION
  RABBIT_MQ_USERNAME      = var.RABBIT_MQ_USERNAME
  RABBIT_MQ_PASSWORD      = var.RABBIT_MQ_PASSWORD
  HOST_INSTANCE_TYPE      = var.HOST_INSTANCE_TYPE
  ENGINE_TYPE             = var.ENGINE_TYPE
  INSTANE_SG              = module.codedeploy.ticket99_secgroup_id
  ECS_APPLICATION         = module.ecs.api_secgroup_id
}

