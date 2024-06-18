#in this template we are creating aws application laadbalancer and target group and alb http listener
##########################
## for ticket99/api ######
##########################

resource "aws_alb" "t99_ecs_alb_api" {
  name           = "${var.APP_NAME}-${var.ENVIRONMENT}-api-alb"
  subnets        = var.PUBLIC_SUBNET_ID
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_target_group" "t99_ecs_tg_api" {
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-api-tg"
  port        = var.ECS_APP_PROT
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.VPC_ID

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.HEALTH_CHECK_PATH
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "api_http" {
  load_balancer_arn = aws_alb.t99_ecs_alb_api.id
  port              = var.ECS_APP_PROT
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "api_https" {
  load_balancer_arn = aws_alb.t99_ecs_alb_api.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ALB_SSL_SECURITY_POLICY
  certificate_arn   = var.ALB_SSL_CERTIFICATE_ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.t99_ecs_tg_api.arn
  }
}

################################
##### for ticket99/admin-api ###
################################

resource "aws_alb" "t99_ecs_alb_admin_api" {
  name           =  "${var.APP_NAME}-${var.ENVIRONMENT}-admin-api-alb"
  subnets        = var.PUBLIC_SUBNET_ID
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_target_group" "t99_ecs_tg_admin_api" {
  name        =  "${var.APP_NAME}-${var.ENVIRONMENT}-admin-api-tg"
  port        = var.ECS_APP_PROT
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.VPC_ID
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.HEALTH_CHECK_PATH
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "api_admin_http" {
  load_balancer_arn = aws_alb.t99_ecs_alb_admin_api.id
  port              = var.ECS_APP_PROT
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "api_admin_https" {
  load_balancer_arn = aws_alb.t99_ecs_alb_admin_api.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ALB_SSL_SECURITY_POLICY
  certificate_arn   = var.ALB_SSL_CERTIFICATE_ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.t99_ecs_tg_admin_api.arn
  }
}
