region      = "us-east-1"

r53record = {
  base_domain="jumisa.io"
  sub_domain="demo"
}

name = "eks-demo"

vpc = {
  cidr = "10.0.0.0/16"
  azs              = ["us-east-1a", "us-east-1b"]
  public_subnets   = ["10.0.32.0/21", "10.0.40.0/21"]
  private_subnets  = ["10.0.0.0/22", "10.0.4.0/22"]
  database_subnets = ["10.0.128.0/23","10.0.130.0/23"]
  # Single NAT Gateway, disabled NGW by AZ
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
}


tags ={
    "Team"            = "DevOps"
    "Owner"           = "Prabhu"
    "ManagedBy"       = "Terraform"
    "Product"         = "Jumisa Demo Project"
}

# cloudflare_api_token = "" Value declared in github secrets