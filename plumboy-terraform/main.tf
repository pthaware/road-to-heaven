module "vpc" {
  source = "./modules/vpc"

  vpc_name = "Plumboy-VPC"
  vpc_cidr = "10.0.0.0/16"

  public_subnets = [
    {
      cidr = "10.0.1.0/24"
      az   = "us-east-1a"
    },
    {
      cidr = "10.0.2.0/24"
      az   = "us-east-1b"
    }
  ]

  private_subnets = [
    {
      cidr = "10.0.10.0/24"
      az   = "us-east-1a"
    },
    {
      cidr = "10.0.11.0/24"
      az   = "us-east-1b"
    }
  ]
}