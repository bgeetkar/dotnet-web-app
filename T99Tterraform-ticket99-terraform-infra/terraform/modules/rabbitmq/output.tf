output "broker_id" {
  value       = join("", aws_mq_broker.rabbitmq_broker.*.id)
  description = "AmazonMQ broker ID"
}

output "broker_arn" {
  value       = join("", aws_mq_broker.rabbitmq_broker.*.arn)
  description = "AmazonMQ broker ARN"
}