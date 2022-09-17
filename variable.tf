

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region for deployments"
}


variable "tfc_vpc_object" {
  type = map(object({
    cidr_vpc             = string,
    vpc_name             = string,
    instance-tenancy     = string,
    enable-dns-support   = bool,
    enable-dns-hostnames = bool
    secondcidr_vpc       = string,

  }))
}

variable "tfc_subnet_object" {
  type = map(object({
    vpc-private-subnet-cidr = string,
    vpc-infra-subnet-cidr   = string,
    private_subnet_name     = string,
    infra-subnets           = string,
    availability_zone       = string,
    pvt-route-name          = string,
    infra-route-name        = string
  }))
}

variable "flow-log" {
  type = string
}
variable "tfc_tgw_object" {
  type = map(object({
    transit_subnets   = string,
    transit-name      = string,
    transit-routes    = string,
    availability_zone = string
  }))
}

variable "tfc_es_object" {
  type = map(object({
    cluster_name                                             = string
    cluster_version                                          = string
    ebs_volume_size                                          = number
    ebs_volume_type                                          = string
    ebs_iops                                                 = number
    master_user_arn                                          = string
    hot_instance_type                                        = string
    master_instance_enabled                                  = bool
    master_instance_count                                    = number
    master_instance_type                                     = string
    hot_instance_count                                       = number
    warm_instance_enabled                                    = bool
    warm_instance_type                                       = string
    warm_instance_count                                      = number
    zone_awareness_enabled                                   = bool
    availability_zones                                       = number
    domain_endpoint_options_enforce_https                    = bool
    domain_endpoint_options_tls_security_policy              = string
    custom_endpoint_enabled                                  = bool
    custom_endpoint                                          = string
    custom_endpoint_certificate_arn                          = string
    advanced_security_options_enabled                        = bool
    advanced_security_options_internal_user_database_enabled = bool
    advanced_security_options_enabled                        = bool
    advanced_security_options_master_user_name               = string
    advanced_security_options_master_user_password           = string
    cognito_options_enabled                                  = bool
    cognito_user_pool_id                                     = string
    cognito_identity_pool_id                                 = string
    cognito_iam_role_arn                                     = string
    env_type                                                 = string
    desired_state                                            = string
    rollback_on_disable                                      = string
    start_at                                                 = string
    cron_expression_for_recurrence                           = string
    maintainence_hours                                       = number


  }))

}

variable "opensearch_logs_group" {
  type = string

}

variable "opensearch_policy_name" {
  type = string

}

variable "flow-log-role-name" {
  type = string

}

variable "cloudwatch-logs-name" {
  type = string

}

variable "tgw-attachment-name" {
  type = string

}

variable "sg_name" {
  type = string

}

variable "service-name" {
  type = string

}

variable "service-type" {
  type = string

}

variable "vpc-endpoint-type" {
  type = string

}

variable "port" {
  type = string

}

variable "protocol" {
  type = string

}

variable "description" {
  type = string

}

# variable "monitor_cluster_index_writes_blocked" {
#   type = bool

# }

variable "tfc_monitor_object" {
  type = map(object({
    prefix = string,
    # evaluation_period = number,
    alarm_cluster_status_is_red_periods = number
    #  statistic_period = number,
    alarm_cluster_status_is_red_period                = number
    alarm_cluster_status_is_yellow_periods            = number
    alarm_cluster_status_is_yellow_period             = number
    alarm_free_storage_space_too_low_periods          = number
    alarm_free_storage_space_too_low_period           = number
    free_storage_space_threshold                      = number
    alarm_free_storage_space_total_too_low_periods    = number
    alarm_free_storage_space_total_too_low_period     = number
    alarm_cluster_index_writes_blocked_periods        = number
    alarm_cluster_index_writes_blocked_period         = number
    alarm_min_available_nodes_periods                 = number
    min_available_nodes                               = number
    alarm_min_available_nodes_period                  = number
    alarm_automated_snapshot_failure_periods          = number
    alarm_automated_snapshot_failure_period           = number
    alarm_cpu_utilization_too_high_periods            = number
    alarm_cpu_utilization_too_high_period             = number
    cpu_utilization_threshold                         = number
    alarm_jvm_memory_pressure_too_high_periods        = number
    alarm_jvm_memory_pressure_too_high_period         = number
    jvm_memory_pressure_threshold                     = number
    alarm_master_cpu_utilization_too_high_periods     = number
    alarm_master_cpu_utilization_too_high_period      = number
    master_cpu_utilization_threshold                  = number
    alarm_master_jvm_memory_pressure_too_high_periods = number
    alarm_master_jvm_memory_pressure_too_high_period  = number
    master_jvm_memory_pressure_threshold              = number
    alarm_kms_periods                                 = number
    alarm_kms_period                                  = number



    # cpu_credit_balance_too_low_threshold = number,
    # cpu_utilization_too_high_threshold = number,
    # disk_queue_depth_too_high_threshold = number,
    # disk_free_storage_space_too_low_threshold = number,
    # disk_burst_balance_too_low_threshold = number,
    # memory_freeable_too_low_threshold = number,
    # memory_swap_usage_too_high_threshold = number,
    # anomaly_band_width = string
    # anomaly_period = string
    # maximum_used_transaction_ids_too_high_threshold = number

  }))
}




# variable "tfc_rds_object" {
#   type = map(object({
#     project                    = string,
#     environment                = string,
#     allocated_storage          = number,
#     engine_version             = string,
#     instance_type              = string,
#     storage_type               = string,
#     iops                       = number,
#     database_identifier        = string,
#     snapshot_identifier        = string,
#     database_name              = string,
#     database_username          = string,
#     database_port              = number,
#     backup_retention_period    = number,
#     backup_window              = string,
#     maintenance_window         = string,
#     auto_minor_version_upgrade = bool,
#     final_snapshot_identifier  = string,
#     skip_final_snapshot        = bool,
#     copy_tags_to_snapshot      = bool,
#     storage_encrypted   = bool,
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
#     anomaly_band_width = string,
#     anomaly_period = string,
#     maximum_used_transaction_ids_too_high_threshold = number


#   }))
# }



