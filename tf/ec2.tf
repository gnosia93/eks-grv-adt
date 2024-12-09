module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["jenkins-x86", "jenkins-grv", "prometheus"])

  name = "i-${each.key}"

  instance_type          = "c6i.xlarge"
  key_name               = "aws-kp-2"
  monitoring             = true
  vpc_security_group_ids = [module.ec2_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address	= "true" 

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# public_subnets
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
# https://library.tf/modules/terraform-aws-modules/ec2-instance/aws/latest
