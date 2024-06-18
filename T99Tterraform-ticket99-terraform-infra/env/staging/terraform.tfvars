#instance
AWS_REGION = "ap-south-2"
INSTANCE_TYPE = "t3.micro"
SECURITY_GROUP_NAME = "staging-sg-group"
APP_NAME = "ticket99"
ENVIRONMENT = "staging"

#Rabbitmq
ENABLE_RABBITMQ = false

##codedeploy 
CODEDEPLOY_INAGE_ID = "ami-0010edab22a90b68d"


#vpc
VPC_NAME = "staging-vpc"
PUBLIC_SUBNET_NAME = "staging-public-sb"
PRIVATE_SUBNET_NAME = "staging-private-sb"
NAT_GATEWAY_NAME = "staging-ngw"
ROUTE_TABLE_NAME = "staging-rtb"
INTERNET_GATEWAY_NAME = "staging-igw"

#redis
ENABLE_REDIS = true
ELASTICACHE_INSTANCE_TYPE = "cache.t3.micro"
ENGINE_VERSION = "7.1"
REDIS_FAMILY = "redis7"

#ecr & ecs
ECR_NAME = ""
ALB_SSL_CERTIFICATE_ARN = "arn:aws:acm:ap-south-2:637423617713:certificate/ab602684-f9f8-418a-8f6e-f817fc52240c"
