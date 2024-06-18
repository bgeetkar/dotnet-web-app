output "vpc_id" {
  value = module.vpc_base.vpc_id
}

output "public_subnets_id" {
  value = module.vpc_base.public_subnets_id
}

output "private_subnet_ids" {
  value = module.vpc_base.private_subnet_ids
}

output "alb_hostname_admin_api" {
  value = module.ecs.alb_hostname_admin_api
}

output "alb_hostname_api" {
  value = module.ecs.alb_hostname_api
}

output "hostname" {
  value = module.redis_cluster.hostname
}

output "redis_hostname" {
  value = module.redis_cluster.hostname
}

output "nuxeo_elasticache_sg_id" {
  value = module.redis_cluster.nuxeo_elasticache_sg_id
}

output "redis_cluster_id" {
  value = module.redis_cluster.redis_cluster_id
}

### code deploy output ##

output "application_id" {
  value = module.codedeploy.application_id
}

output "application_name" {
  value = module.codedeploy.application_name
}

output "deployment_group_id" {
  value = module.codedeploy.deployment_group_id
}

output "deployment_config_name" {
  value = module.codedeploy.deployment_config_name
}

output "security_group" {
  value = module.codedeploy.ticket99_secgroup_id
}