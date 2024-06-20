resource "aws_mq_broker" "rabbitmq_broker" {
  count               = var.ENABLE_RABBITMQ ? 1 : 0    
  broker_name         = "${var.APP_NAME}-${var.ENVIRONMENT}-rabbitmq-server"
  engine_type         = var.ENGINE_TYPE
  engine_version      = var.RABBITMQ_ENGINE_VERSION 
  host_instance_type  = var.HOST_INSTANCE_TYPE 
  deployment_mode     = "SINGLE_INSTANCE"
  subnet_ids          = [split(",", var.PUBLIC_SUBNET_ID)[0]]
  publicly_accessible = false
  security_groups = [aws_security_group.rabbitmq_sg[count.index].id]
  configuration {
    id       = aws_mq_configuration.rabbitmq_broker_config[count.index].id
    revision = aws_mq_configuration.rabbitmq_broker_config[count.index].latest_revision
  }
  user {
    username = var.RABBIT_MQ_USERNAME
    password = var.RABBIT_MQ_PASSWORD
  }

  auto_minor_version_upgrade = false
  apply_immediately = true
  tags = merge(local.default_tags, tomap({"Name" = "${var.APP_NAME}-${var.ENVIRONMENT}-rabbitmq-broker"}))
}


resource "aws_mq_configuration" "rabbitmq_broker_config" {
  count       = var.ENABLE_RABBITMQ ? 1 : 0
  description    = "${var.APP_NAME}-${var.ENVIRONMENT}-rabbitmq-server-configuration "
  name           = "${var.APP_NAME}-${var.ENVIRONMENT}-rabbitmq-config"
  engine_type    = var.ENGINE_TYPE
  engine_version = var.RABBITMQ_ENGINE_VERSION 
  data           = <<DATA
    # Default RabbitMQ delivery acknowledgement timeout is 30 minutes in milliseconds
    consumer_timeout = 1800000
    DATA
}