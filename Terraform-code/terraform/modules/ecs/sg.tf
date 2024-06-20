# security group creation and attcahing in ecs, alb etc

################################
##### for ticket99/api #########
################################

# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "ecs_alb_sg" {
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-ecs-alb-sg"
  description = "Security group for access the ecs"
  vpc_id      = var.VPC_ID

  ingress {
    protocol    = "tcp"
    from_port   = var.ECS_APP_PROT
    to_port     = var.ECS_APP_PROT
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "alb_sg" {
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-ecs-app-alb-sg"
  description = "Security group for access the ecs"
  vpc_id      = var.VPC_ID
}

resource "aws_security_group_rule" "alb_ingress_rules" {
  count             = length(var.APP_PORTS)
  type              = "ingress"
  from_port         = var.APP_PORTS[count.index]
  to_port           = var.APP_PORTS[count.index]
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}