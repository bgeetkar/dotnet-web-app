output "hostname" {
  value = join("", aws_elasticache_replication_group.redis.*.primary_endpoint_address)
}

output "redis_cluster_id" {
  value = join("",aws_elasticache_replication_group.redis.*.id)
}

output "nuxeo_elasticache_sg_id" {
  value = join("",aws_security_group.elasticache_sg.*.id)
}
