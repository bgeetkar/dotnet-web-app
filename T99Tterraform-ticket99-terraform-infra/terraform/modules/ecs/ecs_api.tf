resource "aws_ecs_cluster" "ecs_cluster_api" {
  name = "${var.APP_NAME}-${var.ENVIRONMENT}-api"
  tags = merge(var.ADDITIONAL_TAGS, tomap({"Name" = "${var.APP_NAME}-${var.ENVIRONMENT}-api"}))
}

data "template_file" "t99_container_api" {
  template = file("${path.module}/image/image.json")

  vars = {
    name           = "${var.APP_NAME}-${var.ENVIRONMENT}-api-container"
    app_image      = "${var.APP_IMAGE_API}:${var.IMAGE_TAG_API}"
    app_port       = var.ECS_APP_PROT
    fargate_cpu    = var.FARGATE_CPU_API
    fargate_memory = var.FARGATE_MEMORY_API
    aws_region     = var.AWS_REGION

    awslogs_group = aws_cloudwatch_log_group.t99_ecs_log_group_api.name
    awslogs_region = var.AWS_REGION
  }
}

resource "aws_ecs_task_definition" "t99_api" {
  family                   = "${var.APP_NAME}-${var.ENVIRONMENT}-api"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.FARGATE_CPU_API
  memory                   = var.FARGATE_MEMORY_API
  container_definitions    = data.template_file.t99_container_api.rendered
  runtime_platform {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "t99_api" {
  name            = "${var.APP_NAME}-${var.ENVIRONMENT}-api"
  cluster         = aws_ecs_cluster.ecs_cluster_api.id
  task_definition = aws_ecs_task_definition.t99_api.arn
  desired_count   = var.APP_COUNT_API
  network_configuration {
    subnets          = var.PUBLIC_SUBNET_ID
    security_groups  = [aws_security_group.ecs_alb_sg.id]
    assign_public_ip = true
  }

  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 1
  }

  tags = local.default_tags

  load_balancer {
    target_group_arn = aws_alb_target_group.t99_ecs_tg_api.arn
    container_name = "${var.APP_NAME}-${var.ENVIRONMENT}-api-container"
    container_port = var.ECS_APP_PROT
  }

  depends_on = [aws_alb_listener.api_http, aws_alb_listener.api_https , aws_iam_role_policy_attachment.ecs_task_execution_role]

  lifecycle {
    ignore_changes =  [ task_definition, ]
    }
}
