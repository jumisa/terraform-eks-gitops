# =============================================== #
# Create VPC Network for EKS Infrastructure
# This module provisions VPC network that includes
# VPC , Subnets, Routes, Route Tables
# Internet Gateway, NAT Gateway 
# Subnets - Public, Private and Database 
# 
# =============================================== #
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = var.name
  cidr = var.vpc.cidr

    # https://www.davidc.net/sites/default/subnets/subnets.html
  azs              = var.vpc.azs
  public_subnets   = var.vpc.public_subnets
  private_subnets  = var.vpc.private_subnets
  database_subnets = var.vpc.database_subnets

  # Single NAT Gateway, disabled NGW by AZ
  enable_nat_gateway = var.vpc.enable_nat_gateway
  single_nat_gateway = var.vpc.single_nat_gateway
  one_nat_gateway_per_az = var.vpc.one_nat_gateway_per_az

  tags = var.tags
}