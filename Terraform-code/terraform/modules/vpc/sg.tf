resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.vpc_id
}