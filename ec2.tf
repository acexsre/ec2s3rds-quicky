module "mufliai_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "mufli-devsg"
  description = "Security group for mufliservices"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.0.0.0/16"]
  ingress_rules            = ["ssh-tcp"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "java-services-dev"

  instance_type          = "t2.micro"
  key_name               = "muflidev"
  vpc_security_group_ids = [module.mufliai_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}