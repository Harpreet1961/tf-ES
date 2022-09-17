# resource "random_password" "this_rds_random_string"{
#   length           = 16
#   special          = false
# }

# resource "aws_secretsmanager_secret" "this_rds_random_password" {
#   name = "rds-psql-master-db-secrettt412"
# }

# resource "aws_secretsmanager_secret_version" "this_secret_password" {
#   secret_id = aws_secretsmanager_secret.this_rds_random_password.id
#   secret_string = random_password.this_rds_random_string.result
# }


 resource "aws_kms_key" "kms" {
  for_each =  var.tfc_es_object

#   tags = merge(
#     {
#       Name        = "DatabaseServer",
#       Project     = "${each.value.project}",
#       Environment = "${each.value.environment}"
#     },
#     var.tags
#   )
 }

# variable "domain" {
#   default = var.cluster_name
# }

resource "aws_iam_service_linked_role" "es" {
  count            = var.create_service_role ? 1 : 0
  aws_service_name = "es.amazonaws.com"
  description = "Role Linked for Amazon OpenSearch"

}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "access_policy" {
  statement {
    actions   = ["es:*"]
    resources = ["arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    effect = "Allow"


  }
}


resource "aws_elasticsearch_domain" "opensearch" {
  for_each = var.tfc_es_object
  domain_name = "${each.value.cluster_name}"
  elasticsearch_version = "OpenSearch_${each.value.cluster_version}"
  access_policies       = data.aws_iam_policy_document.access_policy.json

  cluster_config {
    dedicated_master_enabled = "${each.value.master_instance_enabled}"
    dedicated_master_count = "${each.value.master_instance_enabled}" ? "${each.value.master_instance_count}" : null
    dedicated_master_type = "${each.value.master_instance_enabled}" ? "${each.value.master_instance_type}" : null

    instance_type = "${each.value.hot_instance_type}"
    instance_count = "${each.value.hot_instance_count}" 

    warm_enabled = "${each.value.warm_instance_enabled}"
    warm_count = "${each.value.warm_instance_enabled}" ? "${each.value.warm_instance_count}" : null
    warm_type = "${each.value.warm_instance_enabled}"  ? "${each.value.warm_instance_type}" : null

    zone_awareness_enabled = "${each.value.zone_awareness_enabled}"

    dynamic "zone_awareness_config" {
      for_each = "${each.value.availability_zones}" > 1 && "${each.value.zone_awareness_enabled}" ? ["${each.value.availability_zones}"] : []

      content {
        availability_zone_count = zone_awareness_config.value
        
      }
      
    }

  #   zone_awareness_config {
  #     for_each = var.tfc_es_object

  #   availability_zone_count =  ("${each.value.zone_awareness_enabled}" == true &&  "${each.value.availability_zones}" > 1 ) ?  "${each.value.availability_zones}" : null




  # }
    
    
    
  }

    advanced_security_options {
    enabled                        = "${each.value.advanced_security_options_enabled}"
    internal_user_database_enabled = "${each.value.advanced_security_options_internal_user_database_enabled}"

    master_user_options {
      master_user_arn = ("${each.value.master_user_arn}" != "") ? "${each.value.master_user_arn}" : data.aws_caller_identity.current.arn
      master_user_name = "${each.value.advanced_security_options_master_user_name}"
      master_user_password = "${each.value.advanced_security_options_master_user_password}"

    }
  }

   node_to_node_encryption {
    enabled = true
  }

   encrypt_at_rest {
    enabled    = true
    kms_key_id = aws_kms_key.kms[each.key].key_id
  }

  domain_endpoint_options {
    enforce_https = "${each.value.domain_endpoint_options_enforce_https}"
    tls_security_policy = "${each.value.domain_endpoint_options_tls_security_policy}"
    custom_endpoint_enabled = "${each.value.custom_endpoint_enabled}"
    custom_endpoint = "${each.value.custom_endpoint_enabled}" ? "${each.value.custom_endpoint}" : null
    custom_endpoint_certificate_arn = "${each.value.custom_endpoint_enabled}" ? "${each.value.custom_endpoint_certificate_arn}" : null
  

  } 

  

  ebs_options {
    
    ebs_enabled = "${each.value.ebs_volume_size}" > 0 ? true : false
    volume_size = "${each.value.ebs_volume_size}"
    volume_type = "${each.value.ebs_volume_type}"
    iops        = "${each.value.ebs_iops}"
  
  }

  vpc_options {

       
    subnet_ids =  "${each.value.zone_awareness_enabled}" == true ? var.subnet_pvt_ids : var.aos_domain_subnet_ids 
    security_group_ids = ["${var.vpc_security_group_ids}"]
    
  }


  cognito_options {
    enabled = "${each.value.cognito_options_enabled}"
    user_pool_id = "${each.value.cognito_user_pool_id}"
    identity_pool_id = "${each.value.cognito_identity_pool_id}"
    role_arn = "${each.value.cognito_iam_role_arn}"
    
  }

  auto_tune_options {
    desired_state = "${each.value.desired_state}"
    rollback_on_disable = "${each.value.rollback_on_disable}"

    maintenance_schedule {
      start_at = "${each.value.start_at}"
     # cron_expression_for_recurrence = "${each.value.cron_expression_for_recurrence}"
     cron_expression_for_recurrence = "cron(${each.value.cron_expression_for_recurrence})"
      duration {
        value = "${each.value.maintainence_hours}"
        unit = "HOURS"
      
      }
      
    }
    
  }



  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch-logs.arn
    log_type = "INDEX_SLOW_LOGS"
    
  }
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch-logs.arn
    log_type = "SEARCH_SLOW_LOGS"
        
  }

  log_publishing_options {
   cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch-logs.arn
   log_type = "ES_APPLICATION_LOGS" 
  }

  depends_on = [aws_iam_service_linked_role.es]

  tags = {
    Environment =  "${each.value.env_type}"
    Name = "demo-${each.value.cluster_name}"
  }

  
}


###############################################################
##### Logs 
###############################################################

resource "aws_cloudwatch_log_group" "opensearch-logs" {
  name = var.opensearch_logs_group
  
}

resource "aws_cloudwatch_log_resource_policy" "opensearch_logs" {
  policy_name = var.opensearch_policy_name
  policy_document = data.aws_iam_policy_document.opensearch_logs.json
}

data "aws_iam_policy_document" "opensearch_logs" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["es.amazonaws.com"]
    }
    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream",
    ]
    resources = [
      "arn:aws:logs:*"
    ]
  }
}

  
  




# resource "aws_db_instance" "postgresql" {

#   for_each =  var.tfc_rds_object
#   allocated_storage               = "${each.value.allocated_storage}"
#   engine                          = "postgres"
#   engine_version                  = "${each.value.engine_version}"
#   identifier                      = "${each.value.database_identifier}"
#   snapshot_identifier             ="${each.value.snapshot_identifier}"
#   instance_class                  = "${each.value.instance_type}"
#   storage_type                    ="${each.value.storage_type}"
#   iops                            = "${each.value.iops}"
#   name                            = "${each.value.database_name}"
#   password                        = aws_secretsmanager_secret_version.this_secret_password.secret_string
#   username                        = "${each.value.database_username}"
#   backup_retention_period         = "${each.value.backup_retention_period}"
#   backup_window                   = "${each.value.backup_window}"
#   maintenance_window              = "${each.value.maintenance_window}"
#   auto_minor_version_upgrade      = "${each.value.auto_minor_version_upgrade}"
#   final_snapshot_identifier       = "${each.value.final_snapshot_identifier}"
#   skip_final_snapshot             = "${each.value.skip_final_snapshot}"
#   copy_tags_to_snapshot           = "${each.value.copy_tags_to_snapshot}"
#   multi_az                        =   "${each.value.environment}" == "dev" ? true : false
#   port                            = "${each.value.database_port}"
#    vpc_security_group_ids          =  ["${var.vpc_security_group_ids}"]
#   db_subnet_group_name            = "${var.subnet_group}"
#  # parameter_group_name            = var.parameter_group
#   storage_encrypted               = "${each.value.storage_encrypted}"
#    kms_key_id                      = aws_kms_key.kms[each.key].arn
#    enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports

#   tags = merge(
#     {
#       Name        = "DatabaseServer",
#       Project     = "${each.value.project}",
#       Environment = "${each.value.environment}"
#     },
#     var.tags
#   )
#   depends_on = [
#     aws_secretsmanager_secret_version.this_secret_password
#   ]
# }

# resource "aws_cloudwatch_log_group" "this" {
#   for_each = {for k, v in var.tfc_rds_object : k => v if var.create_cloudwatch_log_group }

#   name              = "/aws/rds/instance1/${each.value.database_identifier}"
#   retention_in_days = var.cloudwatch_log_group_retention_in_days
#   kms_key_id        = var.cloudwatch_log_group_kms_key_id

#   tags = var.tags
# }


