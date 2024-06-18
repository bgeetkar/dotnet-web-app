output "application_id" {
  description = "The application ID."
  value       = aws_codedeploy_app.ticket99_codedeploy.id
}

output "application_name" {
  description = "The application's name."
  value       = aws_codedeploy_app.ticket99_codedeploy.name
}

output "deployment_group_id" {
  description = "The application group ID."
  value       = aws_codedeploy_deployment_group.ticket99_codedeploy_deployment_group.deployment_group_id
}

output "deployment_config_name" {
  description = "The deployment group's config name."
  value       = aws_codedeploy_deployment_group.ticket99_codedeploy_deployment_group.deployment_config_name
}

output "ticket99_secgroup_id" {
  value = aws_security_group.alb_sg.id
}

