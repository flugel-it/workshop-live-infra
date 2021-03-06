locals {
  env_variables = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment   = local.env_variables.locals.environment
  region        = local.env_variables.locals.aws_region

}

terraform {
  source = "git@github.com:flugel-it/workshop-ec2.git?ref=v1.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  region        = "${local.region}"
  ami           = {"us-east-1"="ami-13be557e"}
  instance_type = "t2.micro"
  tags = {
    "environment" = "${local.environment}"
  }
}
