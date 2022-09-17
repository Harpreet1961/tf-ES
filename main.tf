# Defining provider


provider "aws" {
  region  = var.aws_region
  profile = "tf-user"
  # version = "~> 4.0"
}

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"

    }

  }


  backend "s3" {

    profile = "tf-user"
  }
}

# terraform {
#   required_version = ">= 1.0.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4"
#     }

#   }
# }




# VPC Module
module "tfc-connect-vpc" {
  source               = "git::https://github.com/Harpreet1961/harpreet.git"
  tfc_vpc_object       = var.tfc_vpc_object
  tfc_subnet_object    = var.tfc_subnet_object
  flow-log-role-name   = var.flow-log-role-name
  flow-log             = var.flow-log
  cloudwatch-logs-name = var.cloudwatch-logs-name
  tgw-attachment-name  = var.tgw-attachment-name
  sg_name              = var.sg_name
  tfc_tgw_object       = var.tfc_tgw_object
  service-name         = var.service-name
  service-type         = var.service-type
  vpc-endpoint-type    = var.vpc-endpoint-type
  port                 = var.port
  protocol             = var.protocol
  description          = var.description

}




data "aws_vpc" "vpc_id" {
  depends_on = [
    module.tfc-connect-vpc
  ]


  filter {
    name   = "tag:Name"
    values = ["*test*", "*test1*"]
  }
}

data "aws_subnet" "subnet" {
  vpc_id = data.aws_vpc.vpc_id.id

  filter {
    name   = "tag:Name"
    values = ["demo-private-subnet1"]
  }



}

data "aws_subnets" "subnets" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_id.id]

  }

  filter {
    name   = "tag:Name"
    values = ["*private*", "*private1*"]

  }

}

# data "aws_subnet" "sample" {
#  # for_each  =   { for k, v in var.tfc_vpc_object : k => v if var.vpc_enabled}
#   for_each = toset(data.aws_subnets.subnets.ids)
#   id = each.value

#   depends_on = [
#     data.aws_subnets.subnets
#   ]
# }

# output "subnet_idss" {
#   value = [for s in data.aws_subnet.sample : s.id]
# }

# data "aws_subnet_ids" "subnet-ids" {

#   vpc_id = data.aws_vpc.vpc_id.id

#   filter {
#     name   = "tag:Name"
#     values = ["*private*", "*private1*"]
#   }


# }

data "aws_security_group" "sg" {

  depends_on = [
    module.tfc-connect-vpc
  ]
  filter {
    name   = "tag:Name"
    values = ["*sg*", "*sg1*"]
  }

}

resource "aws_db_subnet_group" "default" {

  # subnet_ids = data.aws_subnet_ids.subnet-ids.ids
  subnet_ids = data.aws_subnets.subnets.ids

  depends_on = [
    module.tfc-connect-vpc
  ]




}

output "subnet-id" {
  value = data.aws_subnet.subnet.id

}

output "subnet-ids" {
  value = data.aws_subnets.subnets.ids

}

module "tfs-es" {
  source                 = "./modules/rds-baseline"
  tfc_es_object          = var.tfc_es_object
  vpc_security_group_ids = data.aws_security_group.sg.id
  #aos_domain_subnet_ids = data.aws_subnet_ids.subnet-ids.ids
  aos_domain_subnet_ids  = [data.aws_subnet.subnet.id]
  subnet_pvt_ids         = data.aws_subnets.subnets.ids
  opensearch_logs_group  = var.opensearch_logs_group
  opensearch_policy_name = var.opensearch_policy_name



  depends_on = [
    module.tfc-connect-vpc
  ]


}

data "aws_elasticsearch_domain" "example" {
  domain_name = "opensearch"
  # domain_name = "opensearch"
  depends_on = [
    module.tfs-es
  ]


}

module "tfc-cloudwatch" {
  source = "./modules/cloudwatch-baseline/"
  depends_on = [
    module.tfs-es
  ]

  tfc_monitor_object = var.tfc_monitor_object
  actions_alarm      = [aws_sns_topic.default.arn]
  domain_name        = data.aws_elasticsearch_domain.example.domain_name




}

# module "postgresql_rds" {
#   source                 = "./modules/rds-baseline"
#   vpc_id                 = data.aws_vpc.vpc_id.id
#   tfc_rds_object         = var.tfc_rds_object
#   vpc_security_group_ids = data.aws_security_group.sg.id
#   subnet_group           = aws_db_subnet_group.default.name
#   cloudwatch_logs_exports = ["postgresql"]

# }

# data "aws_db_instance" "rds_id" {
#   db_instance_identifier = "rds"
#   depends_on = [
#     module.postgresql_rds
#   ]

# }

resource "aws_sns_topic" "default" {
  name_prefix = "my-premade-topic"
}






