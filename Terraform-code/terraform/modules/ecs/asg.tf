resource "aws_appautoscaling_target" "ecs_target_admin_api" {
  max_capacity       = var.MAX_CAPACITY_ADMIN_API
  min_capacity       = var.MIN_CAPACITY_ADMIN_API
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster_admin_api.name}/${aws_ecs_service.t99_api_admin_api.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

#Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "ecs_policy_up_admin_api" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster_admin_api.name}/${aws_ecs_service.t99_api_admin_api.name}"
  scalable_dimension = aws_appautoscaling_target.ecs_target_admin_api.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target_admin_api.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

####################################################################

resource "aws_appautoscaling_target" "ecs_target_api" {
  max_capacity       = var.MAX_CAPACITY_API
  min_capacity       = var.MIN_CAPACITY_API
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster_api.name}/${aws_ecs_service.t99_api.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

#Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "ecs_policy_up_api" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster_api.name}/${aws_ecs_service.t99_api.name}"
  scalable_dimension = aws_appautoscaling_target.ecs_target_api.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target_api.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}