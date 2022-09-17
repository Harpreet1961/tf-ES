
variable "vpc_security_group_ids" {
   
}

variable "aos_domain_subnet_ids" {
 #  type = list(string)
}

variable "subnet_pvt_ids" {
  
}

# variable "subnet_ids" {
#   type        = list(string)
#   description = "VPC Subnet IDs"
#   default     = []
# }

variable "create_service_role" {
  description = "Indicates whether to create the service-linked role. See https://docs.aws.amazon.com/opensearch-service/latest/developerguide/slr.html"
  type        = bool
  default     = true
}

# variable "cluster_name" {
#   description = "The name of the OpenSearch cluster."
#   type        = string
#   default     = "opensearch"
# }

# variable "cluster_version" {
#   description = "The version of OpenSearch to deploy."
#   type        = string
#   default     = "1.3"
# }

# variable "ebs_volume_size" {
#   type        = number
#   description = "EBS volumes for data storage in GB"
#   default     = 10
# }

# variable "ebs_volume_type" {
#   type        = string
#   default     = "gp2"
#   description = "Storage type of EBS volumes"
# }

# variable "ebs_iops" {
#   type        = number
#   default     = 0
#   description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
# }

# variable "master_user_arn" {
#   description = "The ARN for the master user of the cluster. If not specified, then it defaults to using the IAM user that is making the request."
#   type        = string
#   default     = ""
# }
# variable "availability_zones" {
#   description = "The number of availability zones for the OpenSearch cluster. Valid values: 1, 2 or 3."
#   type        = number
#   default     = 2
# }
variable "tfc_es_object" {
  type = map(object({
    cluster_name = string
    cluster_version = string
    ebs_volume_size = number
    ebs_volume_type =string
    ebs_iops = number
    master_user_arn = string
    hot_instance_type = string
    master_instance_enabled = bool
    master_instance_count = number
    master_instance_type = string
    hot_instance_count = number
    warm_instance_enabled = bool
    warm_instance_type = string
    warm_instance_count = number
    zone_awareness_enabled = bool
    availability_zones = number
    domain_endpoint_options_enforce_https = bool
    domain_endpoint_options_tls_security_policy = string
    custom_endpoint_enabled = bool
    custom_endpoint = string
    custom_endpoint_certificate_arn = string 
    advanced_security_options_enabled = bool
    advanced_security_options_internal_user_database_enabled = bool
    advanced_security_options_master_user_name = string
    advanced_security_options_master_user_password = string
    cognito_options_enabled = bool
    cognito_user_pool_id = string
    cognito_identity_pool_id = string
    cognito_iam_role_arn = string
    env_type = string
    desired_state = string
    rollback_on_disable = string
    start_at = string
    cron_expression_for_recurrence = string
    maintainence_hours = number

    




  }))
  
}

variable "opensearch_logs_group" {
  type = string
  
}

variable "opensearch_policy_name" {
  type = string
  
}
# variable "tfc_rds_object" {
#   type = map(object({
#     project  = string,
#     environment = string,
#     allocated_storage = number,
#     engine_version = string,
#     instance_type  = string,
#     storage_type  = string,
#     iops  =   number,
#     database_identifier = string,
#     snapshot_identifier = string,
#     database_name = string,
#     database_username = string,
#     database_port = number,
#     backup_retention_period = number,
#     backup_window = string,
#     maintenance_window = string,
#     auto_minor_version_upgrade = bool,
#     final_snapshot_identifier = string,
#     skip_final_snapshot = bool,
#     copy_tags_to_snapshot = bool,
#     storage_encrypted = bool,
#     deletion_protection = bool,
#     evaluation_period = number,
#     statistic_period = number,
#     cpu_utilization_too_high_threshold = number,
#     cpu_credit_balance_too_low_threshold = number,
#     disk_queue_depth_too_high_threshold = number,
#     disk_free_storage_space_too_low_threshold = number,
#     disk_burst_balance_too_low_threshold = number,
#     memory_freeable_too_low_threshold = number,
#     memory_swap_usage_too_high_threshold = number,
#     anomaly_band_width = string
#     anomaly_period = string
#     maximum_used_transaction_ids_too_high_threshold = number
  
#   }))
# }

# variable "actions_alarm" {
#   type        = list
#   default     = []
#   description = "A list of actions to take when alarms are triggered. Will likely be an SNS topic for event distribution."
# }


# variable "vpc_id" {
#   type        = string
#   description = "ID of VPC meant to house database"
# }

# variable "cloudwatch_logs_exports" {
#   default     = ["postgresql", "upgrade"]
#   type        = list
#   description = "List of logs to publish to CloudWatch Logs"
# }

# variable "subnet_group" {
#   type        = string
#   description = "Database subnet group"
# }

# variable "create_low_cpu_credit_alarm" {
#   type        = bool
#   default     = true
#   description = "Whether or not to create the low cpu credit alarm.  Default is to create it (for backwards compatible support)"
# }


# variable "tags" {
#   default     = {}
#   type        = map(string)
#   description = "Extra tags to attach to the RDS resources"
# }


# variable "create_cloudwatch_log_group" {
#   type = bool
#   default = true
  
# }
# variable "cloudwatch_log_group_retention_in_days" {
#   description = "The number of days to retain CloudWatch logs for the DB instance"
#   type        = number
#   default     = 7
# }

# variable "cloudwatch_log_group_kms_key_id" {
#   description = "The ARN of the KMS Key to use when encrypting log data"
#   type        = string
#   default     = null
# }



# variable "create_high_cpu_alarm" {
#     type = bool
#     default = true
  
# }

# variable "create_high_queue_depth_alarm" {
#     type = bool
#     default = true
  
# }

# variable "create_low_disk_space_alarm" {
#     type = bool
#     default = true
  
# }

# variable "create_low_disk_burst_alarm" {
#     type = bool
#     default = true  
# }

# variable "create_low_memory_alarm" {
#     type = bool
#     default = true
  
# }

# variable "create_swap_alarm" {
#     type = bool
#     default = true
  
# }

# variable "create_anomaly_alarm" {
#     type = bool
#     default = true
  
# }