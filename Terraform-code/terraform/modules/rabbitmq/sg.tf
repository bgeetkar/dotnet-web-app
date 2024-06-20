resource "aws_security_group" "rabbitmq_sg" {
  count       = var.ENABLE_RABBITMQ ? 1 : 0
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-rabbitmq-sg"
  description = "Security group for RabbitMQ broker"
  
  vpc_id = var.VPC_ID
}

## INGRESS RULE #1
resource "aws_security_group_rule" "rabbitmq_sg" {
  count       = var.ENABLE_RABBITMQ ? 1 : 0
  type = "ingress"
  from_port = 5671
  to_port = 5671
  protocol = "tcp"
  security_group_id = aws_security_group.rabbitmq_sg[count.index].id
  source_security_group_id = var.INSTANE_SG
}

## INGRESS RULE #1
resource "aws_security_group_rule" "rabbitmq_web_sg" {
  count       = var.ENABLE_RABBITMQ ? 1 : 0
  type = "ingress"
  from_port = 8162
  to_port = 8162
  protocol = "tcp"
  security_group_id = aws_security_group.rabbitmq_sg[count.index].id
  cidr_blocks = [ "0.0.0.0/0" ]
}

## Egress RULE #2
resource "aws_security_group_rule" "egress_rabbitmq_sg" {
  count = var.ENABLE_RABBITMQ ? 1 : 0
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  security_group_id = aws_security_group.rabbitmq_sg[count.index].id
  cidr_blocks = [ "0.0.0.0/0" ]
}