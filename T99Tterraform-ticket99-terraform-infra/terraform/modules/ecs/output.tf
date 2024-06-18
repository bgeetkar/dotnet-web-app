output "ecs_cluster_arn_api" {
  value       = aws_ecs_cluster.ecs_cluster_api.arn
  description = "ARN of the ECS cluster"
}

output "ecs_cluster_id_api" {
  description = "ID of the ECS Cluster"
  value       =  aws_ecs_cluster.ecs_cluster_api.id
}

output "alb_hostname_api" {
  value = aws_alb.t99_ecs_alb_api.dns_name
}

###########################################################

output "ecs_cluster_arn_admin_api" {
  value       = aws_ecs_cluster.ecs_cluster_admin_api.arn
  description = "ARN of the ECS cluster"
}

output "ecs_cluster_id_admin_api" {
  description = "ID of the ECS Cluster"
  value       =  aws_ecs_cluster.ecs_cluster_admin_api.id
}

output "alb_hostname_admin_api" {
  value = aws_alb.t99_ecs_alb_admin_api.dns_name
}

output "api_secgroup_id" {
  value = aws_security_group.ecs_alb_sg.id
}
