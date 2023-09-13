module "public_alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "public-alb-lb"
  description = "Security group for public internet facing load balancer"
  vpc_id      = module.main_vpc.id 

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "http"
      description = "public-load-balancer-port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
     from_port = 443
     to_port = 443
     protocol = "tcp"
     cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "private_ecs_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "private-ecs-lb"
  description = "Security group to allow loadbalancer into ECS"
  vpc_id      = module.main_vpc.id 

  ingress_with_source_security_group_id = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      source_security_group_id = module.public_alb_sg.id
    },
    {
     from_port = 443
     to_port = 443
     protocol = "tcp"
     cidr_blocks = "0.0.0.0/0"
    },
  ]
}