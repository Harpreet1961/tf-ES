# # Define Variables


tfc_vpc_object = {
  "vpc_object" = {
    cidr_vpc             = "10.142.53.0/24"
    instance-tenancy     = "default"
    vpc_name             = "test-vpc"
    enable-dns-support   = true
    enable-dns-hostnames = true
    secondcidr_vpc       = "172.0.0.0/16"

  }
}




tfc_subnet_object = {
  "primary_subnet_object" = {
    vpc-private-subnet-cidr = "10.142.53.64/28"
    vpc-infra-subnet-cidr   = "10.142.53.112/28"
    private_subnet_name     = "demo-private-subnet1"
    availability_zone       = "us-west-2a"
    infra-subnets           = "Infra-Demo1"
    pvt-route-name          = "pvt-route-table1",
    infra-route-name        = "infra-route-table1"
  },
  "secondary_subnet_object" = {
    vpc-private-subnet-cidr = "10.142.53.80/28"
    vpc-infra-subnet-cidr   = "10.142.53.128/28"
    private_subnet_name     = "demo-private-subnet3"
    availability_zone       = "us-west-2b"
    infra-subnets           = "Infra-Demo3"
    pvt-route-name          = "pvt-route-table3",
    infra-route-name        = "infra-route-table3"
  }


}

tfc_tgw_object = {
  "transit_subnets_object" = {
    transit-name      = "tgw-subnet1"
    transit_subnets   = "10.142.53.16/28"
    transit-routes    = "transit-route-table1"
    availability_zone = "us-west-2b"

  },
  "transit_sec_subnets_object" = {
    transit-name      = "tgw-subnet2"
    transit_subnets   = "10.142.53.32/28"
    transit-routes    = "transit-route-table2"
    availability_zone = "us-west-2c"

  }

}

flow-log = "test-vpc-flow-logs"

tfc_es_object = {
  "es_obj" = {
    cluster_name                                             = "opensearch"
    cluster_version                                          = "1.3"
    ebs_volume_size                                          = "10"
    ebs_volume_type                                          = "gp2"
    ebs_iops                                                 = "0"
    master_user_arn                                          = ""
    hot_instance_type                                        = "t3.small.elasticsearch"
    master_instance_enabled                                  = false
    master_instance_count                                    = "3"
    master_instance_type                                     = "r6gd.large.elasticsearch"
    hot_instance_count                                       = "4"
    warm_instance_enabled                                    = false
    warm_instance_type                                       = "ultrawarm1.large.elasticsearch"
    warm_instance_count                                      = "3"
    zone_awareness_enabled                                   = true
    availability_zones                                       = 2
    domain_endpoint_options_enforce_https                    = true
    domain_endpoint_options_tls_security_policy              = "Policy-Min-TLS-1-0-2019-07"
    custom_endpoint_enabled                                  = false
    custom_endpoint                                          = ""
    custom_endpoint_certificate_arn                          = ""
    advanced_security_options_enabled                        = true
    advanced_security_options_internal_user_database_enabled = false
    advanced_security_options_master_user_name               = ""
    advanced_security_options_master_user_password           = ""
    cognito_options_enabled                                  = false
    cognito_user_pool_id                                     = ""
    cognito_identity_pool_id                                 = ""
    cognito_iam_role_arn                                     = ""
    env_type                                                 = "Provider Tag"
    desired_state                                            = "ENABLED"
    rollback_on_disable                                      = "NO_ROLLBACK"
    start_at                                                 = "2022-09-11T03:00:00.00Z"
    cron_expression_for_recurrence                           = "0 12 ? * 1 *"
    maintainence_hours                                       = 2


  }

}

flow-log-role-name     = "vpc-cloudwatch-role"
opensearch_logs_group  = "opensearch_cloudwatch_log_group"
opensearch_policy_name = "opensearch_policy"
cloudwatch-logs-name   = "test-cloudwatch-logs1"
tgw-attachment-name    = "tgw-attachment"
sg_name                = "sg-vpc"
service-name           = "s3"
service-type           = "Interface"
vpc-endpoint-type      = "Interface"
port                   = "5432"
protocol               = "tcp"
description            = "Allo PSQL"
# monitor_cluster_index_writes_blocked = true

tfc_monitor_object = {
  "monitor_obj" = {
    prefix = "",
    # evaluation_period = number,
    alarm_cluster_status_is_red_periods = 1
    #  statistic_period = number,
    alarm_cluster_status_is_red_period                = 60
    alarm_cluster_status_is_yellow_periods            = 1
    alarm_cluster_status_is_yellow_period             = 60
    alarm_free_storage_space_too_low_periods          = 1
    alarm_free_storage_space_too_low_period           = 60
    free_storage_space_threshold                      = 20480 ## 20 Gigabyte in MegaByte
    alarm_free_storage_space_total_too_low_periods    = 1
    alarm_free_storage_space_total_too_low_period     = 60
    alarm_cluster_index_writes_blocked_periods        = 1
    alarm_cluster_index_writes_blocked_period         = 300
    alarm_min_available_nodes_periods                 = 1
    min_available_nodes                               = 0
    alarm_min_available_nodes_period                  = 86400
    alarm_automated_snapshot_failure_periods          = 1
    alarm_automated_snapshot_failure_period           = 60
    alarm_cpu_utilization_too_high_periods            = 3
    alarm_cpu_utilization_too_high_period             = 900
    cpu_utilization_threshold                         = 80
    alarm_jvm_memory_pressure_too_high_periods        = 1
    alarm_jvm_memory_pressure_too_high_period         = 900
    jvm_memory_pressure_threshold                     = 80
    alarm_master_cpu_utilization_too_high_periods     = 3
    alarm_master_cpu_utilization_too_high_period      = 900
    master_cpu_utilization_threshold                  = 80
    alarm_master_jvm_memory_pressure_too_high_periods = 1
    alarm_master_jvm_memory_pressure_too_high_period  = 900
    master_jvm_memory_pressure_threshold              = 80
    alarm_kms_periods                                 = 1
    alarm_kms_period                                  = 60





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

  }
}




# tfc_rds_object = {
#   "primary_database" = {
#     project                    = "Something1",
#     environment                = "Staging",
#     allocated_storage          = "32",
#     engine_version             = "13.4",
#     instance_type              = "db.t3.micro",
#     storage_type               = "gp2",
#     iops                       = "0",
#     database_identifier        = "rds",
#     snapshot_identifier        = "",
#     database_name              = "hector",
#     database_username          = "hector",
#     database_port              = "5432",
#     backup_retention_period    = "30",
#     backup_window              = "04:00-04:30",
#     maintenance_window         = "sun:04:30-sun:05:30",
#     auto_minor_version_upgrade = false,
#     final_snapshot_identifier  = "terraform-aws-postgresql-rds-snapshot",
#     skip_final_snapshot        = true,
#     copy_tags_to_snapshot      = false,
#     storage_encrypted   = true,
#     deletion_protection = true,
#     evaluation_period                               = "5",
#     statistic_period                                = "60",
#     cpu_credit_balance_too_low_threshold            = "100",
#     cpu_utilization_too_high_threshold              = "75",
#     disk_queue_depth_too_high_threshold             = "10"
#     disk_free_storage_space_too_low_threshold       = "10000000000" // 10GB
#     disk_burst_balance_too_low_threshold            = "100"
#     memory_freeable_too_low_threshold               = "256000000" // 256 MB,
#     memory_swap_usage_too_high_threshold            = "256000000" // 256 MB
#     anomaly_band_width                              = "2"
#     anomaly_period                                  = "600"
#     maximum_used_transaction_ids_too_high_threshold = "1000000000" // 1 billion. Half of total

#   }
# }
