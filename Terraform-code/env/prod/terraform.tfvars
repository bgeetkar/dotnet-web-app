#instance
AWS_REGION = "us-east-1"
INSTANCE_TYPE = "t3.micro"
SECURITY_GROUP_NAME = "sg-group"
APP_NAME = "ticket99"
ENVIRONMENT = "prod"

#Rabbitmq
ENABLE_RABBITMQ = false

##codedeploy 
CODEDEPLOY_INAGE_ID = "ami-0b95b68147742ba5e"


#vpc
VPC_NAME = "vpc"
PUBLIC_SUBNET_NAME = "public-sb"
PRIVATE_SUBNET_NAME = "private-sb"
NAT_GATEWAY_NAME = "ngw"
ROUTE_TABLE_NAME = "rtb"
INTERNET_GATEWAY_NAME = "igw"

#redis
ENABLE_REDIS = true
ELASTICACHE_INSTANCE_TYPE = "cache.t3.micro"
ENGINE_VERSION = "7.1"
REDIS_FAMILY = "redis7"

#ecr & ecs
ECR_NAME = ""
