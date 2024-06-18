# security group creation and attcahing in ecs, alb etc

################################
##### for ticket99/web-api #####
################################

# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "alb_sg" {
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-alb-sg"
  description = "controls access to the ALB"
  vpc_id      = var.VPC_ID

}

resource "aws_security_group_rule" "alb_ingress_rules" {
  count = length(var.APP_PORTS)
  type = "ingress"
  from_port = var.APP_PORTS[count.index]
  to_port = var.APP_PORTS[count.index]
  protocol = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_rules" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

#    dynamic "ingress" {
#     for_each = var.APP_PORTS
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_security_group" "web_sg" {
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-web-sg"
  description = "controls access to the ALB"
  vpc_id      = var.VPC_ID
}

resource "aws_security_group_rule" "web_alb_access" {
  count = length(var.APP_PORTS)
  type = "ingress"
  from_port = var.APP_PORTS[count.index]
  to_port = var.APP_PORTS[count.index]
  protocol = "tcp"
  security_group_id = aws_security_group.web_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "web_rdp_access" {
  type = "ingress"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  security_group_id = aws_security_group.web_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_egress_rules" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  security_group_id = aws_security_group.web_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

  # dynamic "ingress" {
  #   for_each = var.APP_PORTS
  #   content {
  #     from_port   = ingress.value
  #     to_port     = ingress.value
  #     protocol    = "tcp"
  #     security_groups = [aws_security_group.alb_sg.id]
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  # }
  # # ingress {
  # #   protocol    = "tcp"
  # #   from_port   = var.APP_PORTS[count.index]
  # #   to_port     = var.APP_PORTS[count.index]
  # #   security_groups = [aws_security_group.alb_sg.id]
  # #   cidr_blocks = ["0.0.0.0/0"]
  # # }

  # ingress {
  #   protocol    = "tcp"
  #   from_port   = "3389"
  #   to_port     = "3389"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # egress {
  #   protocol    = "-1"
  #   from_port   = 0
  #   to_port     = 0
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
# }
