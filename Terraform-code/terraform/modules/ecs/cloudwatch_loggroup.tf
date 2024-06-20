##########################
## for ticket99/api ######
##########################

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "t99_ecs_log_group_api" {
  name              = "/ecs/t99_app"
  retention_in_days = 30

  tags = {
    Name = "/ecs/t99_app"
  }
}

resource "aws_cloudwatch_log_stream" "t99_ecs_log_stream_api" {
  name           = "log-stream-${var.APP_NAME}-${var.ENVIRONMENT}"
  log_group_name = aws_cloudwatch_log_group.t99_ecs_log_group_api.name
}

################################
##### for ticket99/admin-api ###
################################

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "t99_ecs_log_group_admin_api" {
  name              = "/ecs/t99_admin_app"
  retention_in_days = 30

  tags = {
    Name = "/ecs/t99_admin_app"
  }
}

resource "aws_cloudwatch_log_stream" "t99_ecs_log_stream_admin_api" {
  name           = "log-stream-${var.APP_NAME}-${var.ENVIRONMENT}"
  log_group_name = aws_cloudwatch_log_group.t99_ecs_log_group_admin_api.name
}