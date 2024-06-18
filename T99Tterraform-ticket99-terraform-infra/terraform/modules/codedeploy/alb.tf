#in this template we are creating aws application laadbalancer and target group and alb http listener
##########################
## for ticket99/web-api ##
##########################

resource "aws_alb" "t99_codedeploy_web_api_alb" {
  name           = "${var.APP_NAME}-${var.ENVIRONMENT}-web-api-alb"
  subnets        = var.PUBLIC_SUBNET_ID
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_target_group" "t99_codedeploy_web_api" {
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-web-api-tg"
  port        = 80
  protocol    = "HTTP"
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
  load_balancer_arn = aws_alb.t99_codedeploy_web_api_alb.id
  port              = 80
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
  load_balancer_arn = aws_alb.t99_codedeploy_web_api_alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ALB_SSL_SECURITY_POLICY
  certificate_arn   = var.ALB_SSL_CERTIFICATE_ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.t99_codedeploy_web_api.arn
  }
}

################################
##### for ticket99/admin-api ###
################################

resource "aws_alb" "t99_codedeploy_web_admin_api_alb" {
  name           =  "${var.APP_NAME}-${var.ENVIRONMENT}-web-admin-alb"
  subnets        = var.PUBLIC_SUBNET_ID
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_target_group" "t99_codedeploy_web_admin_api_tg" {
  name        =  "${var.APP_NAME}-${var.ENVIRONMENT}-web-admin-tg"
  port        = 80
  protocol    = "HTTP"
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
resource "aws_alb_listener" "web_admin_http" {
  load_balancer_arn = aws_alb.t99_codedeploy_web_admin_api_alb.id
  port              = 80
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
  load_balancer_arn = aws_alb.t99_codedeploy_web_admin_api_alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ALB_SSL_SECURITY_POLICY
  certificate_arn   = var.ALB_SSL_CERTIFICATE_ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.t99_codedeploy_web_admin_api_tg.arn
  }
}
