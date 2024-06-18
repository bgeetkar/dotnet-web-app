##########################
## for ticket99/web-api ##
##########################
# create a CodeDeploy application
resource "aws_codedeploy_app" "ticket99_codedeploy" {
  name = "${var.APP_NAME}-${var.ENVIRONMENT}-codedeploy-application"
}

# create a deployment group
resource "aws_codedeploy_deployment_group" "ticket99_codedeploy_deployment_group" {
  app_name              = aws_codedeploy_app.ticket99_codedeploy.name
  deployment_group_name = "${var.APP_NAME}-${var.ENVIRONMENT}-deployment-group"
  service_role_arn      = aws_iam_role.ticket99_codedeploy_service.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime" # AWS defined deployment config
 
  ec2_tag_filter {
    key   = "ENVIRONMENT"
    type  = "KEY_AND_VALUE"
    value = var.ENVIRONMENT
  }

  ec2_tag_filter {
    key   = "SERVICE"
    type  = "KEY_AND_VALUE"
    value = var.SERVICE
  }

  # trigger a rollback on deployment failure event
  auto_rollback_configuration {
    enabled = false
    events = [
      "DEPLOYMENT_FAILURE",
    ]
  }

  # Define the load balancer configuration
  # load_balancer_info {
  #   target_group_pair_info {
  #     prod_traffic_route {
  #       listener_arns = [aws_alb_target_group.t99_codedeploy_web_api.arn]
  #     }

  #     target_group {
  #       name = aws_alb_target_group.t99_codedeploy_web_api.name
  #     }
  #   }
  # }
}

################################
## for ticket99/web-admin api ##
################################

# create a CodeDeploy admin application
resource "aws_codedeploy_app" "ticket99_codedeploy_admin" {
  name = "${var.APP_NAME}-${var.ENVIRONMENT}-admin-codedeploy-application"
}

# create a deployment group
resource "aws_codedeploy_deployment_group" "ticket99_admin_codedeploy_deployment_group" {
  app_name              = aws_codedeploy_app.ticket99_codedeploy_admin.name
  deployment_group_name = "${var.APP_NAME}-${var.ENVIRONMENT}-admin-deployment-group"
  service_role_arn      = aws_iam_role.ticket99_codedeploy_service.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime" # AWS defined deployment config

  ec2_tag_filter {
    key   = "ENVIRONMENT"
    type  = "KEY_AND_VALUE"
    value = var.ENVIRONMENT
  }

  ec2_tag_filter {
    key   = "SERVICE"
    type  = "KEY_AND_VALUE"
    value = var.SERVICE
  }

  # trigger a rollback on deployment failure event
  auto_rollback_configuration {
    enabled = true
    events = [
      "DEPLOYMENT_FAILURE",
    ]
  }

  # Define the load balancer configuration
  # load_balancer_info {
  #   target_group_pair_info {
  #     prod_traffic_route {
  #       listener_arns = [aws_alb_target_group.t99_codedeploy_web_admin_api_tg.arn]
  #     }

  #     target_group {
  #       name = aws_alb_target_group.t99_codedeploy_web_admin_api_tg.name
  #     }
  #   }
  # }
}





