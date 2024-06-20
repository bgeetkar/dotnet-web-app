#-------------------
# Elastic Cache Redis
# replication_group_id can't be more than 20 character
# also it should not be end with hyphen
#-------------------

resource "aws_elasticache_parameter_group" "redis_param_group" {
  name        = var.PARAMETER_GROUP_NAME
  family      = var.REDIS_FAMILY
  description = "Parameter group for Redis 7.1"
}

resource "aws_elasticache_replication_group" "redis" {
  count = var.ENABLE_REDIS ? 1 : 0
  replication_group_id          = "${format("%.19s","${var.APP_NAME}-${var.ENVIRONMENT}")}r"
  description                   = "redis"
  node_type                     = var.ELASTICACHE_INSTANCE_TYPE
  num_cache_clusters            = var.NR_CACHE_NODES
  port                          = var.REDIS_PORT
  engine_version                = var.ENGINE_VERSION
  parameter_group_name          = aws_elasticache_parameter_group.redis_param_group.name
  subnet_group_name             = aws_elasticache_subnet_group.redis[count.index].name
  security_group_ids            = [aws_security_group.elasticache_sg[count.index].id]
  snapshot_retention_limit      = var.ELASTICACHE_BACKUP_RENTENTION
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs = split(",",var.ELASTICACHE_AVAILABILITY_ZONES)
  apply_immediately = true
  auto_minor_version_upgrade    = false
  at_rest_encryption_enabled    = var.USE_REDIS_AT_REST_ENCRYPTION
  transit_encryption_enabled    = var.USE_REDIS_TRANSIT_ENCRYPTION

  tags = merge(local.default_tags, tomap({"Name" = "${var.APP_NAME}-${var.ENVIRONMENT}-redis"}))
}

resource "aws_elasticache_subnet_group" "redis" {
  count = var.ENABLE_REDIS ? 1 : 0
  name        = "${var.APP_NAME}-${var.ENVIRONMENT}-redis-sn-grp"
  description = "public subnets for the ElastiCache instances"
  subnet_ids  = var.PUBLIC_SUBNET_ID
}
