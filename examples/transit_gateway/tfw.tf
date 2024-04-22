##Transit Gateway cross account

module "tgw_us-east-1" {
  source = "../../modules/transit_gateway"
  name = "sample"
  environment = "hml"
  region = "us-east-1"
  account_ids = ["483673615578","857814700495","271435899528"]
  providers = {
    aws = aws.us-east-1
  }
}

##VPC Attachment

module "tgw_attach1" {
    source = "../../modules/tgw_vpc_attach"
    environment = "hml"
    tgw_id = module.tgw_us-east-1.id
    vpc_id = "vpc-0dd70ea0aca3f0c83"
    subnets = ["subnet-02d4b57b04cbd4236","subnet-0856a2fdaaf4f200a","subnet-088d54897f84526fd"] 
}