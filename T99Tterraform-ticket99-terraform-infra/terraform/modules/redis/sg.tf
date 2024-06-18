resource "aws_security_group" "elasticache_sg" {
  count = var.ENABLE_REDIS ? 1 : 0
  name = "${var.APP_NAME}-${var.ENVIRONMENT}-elasticache-sg"
  vpc_id = var.VPC_ID
  description = "Allows incoming http and ssh"
  ingress {
    protocol        = "tcp"
    from_port       = 6379
    to_port         = 6379
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.default_tags, tomap({"Name" = "${var.APP_NAME}-${var.ENVIRONMENT}-elasticache-sg"}))
}