
# // CPU Utilization

resource "aws_cloudwatch_metric_alarm" "namecluster_status_is_red" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.monitor_cluster_status_is_red }
    alarm_name = "${each.value.prefix}opensearch-clusterstatusred"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "${each.value.alarm_cluster_status_is_red_periods}"
    metric_name = "ClusterStatus.red"
    namespace = "AWS/ES"
    period = "${each.value.alarm_cluster_status_is_red_period}"
    statistic = "Maximum"
    threshold = "1"
    alarm_description = "Average elasticsearch cluster status is in red over last"
    alarm_actions = var.actions_alarm
    treat_missing_data = "ignore"

    dimensions = {
        domain_name = var.domain_name
        
    }

    tags = var.tags
  
}


resource "aws_cloudwatch_metric_alarm" "cluster_status_is_yellow" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.monitor_cluster_status_is_yellow }
    alarm_name = "${each.value.prefix}opensearch-ClusterStatusIsYellow"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "${each.value.alarm_cluster_status_is_yellow_periods}"
    datapoints_to_alarm = "${each.value.alarm_cluster_status_is_yellow_periods}"
    metric_name = "ClusterStatus.yellow"
    namespace = "AWS/ES"
    period = "${each.value.alarm_cluster_status_is_yellow_period}"
    statistic = "Maximum"
    threshold = "1"
    alarm_description = "Average elasticsearch cluster status is in red Yellow"
    alarm_actions = var.actions_alarm
    treat_missing_data = "ignore"

    dimensions = {
        domain_name = var.domain_name
        
    }

    tags = var.tags

  
}

resource "aws_cloudwatch_metric_alarm" "free_storage_space_too_low" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.monitor_free_storage_space_too_low }
    alarm_name = "${each.value.prefix}opensearch-FreeStorageSpaceTooLow"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "${each.value.alarm_free_storage_space_too_low_periods}"
    datapoints_to_alarm = "${each.value.alarm_free_storage_space_too_low_periods}"
    metric_name = "FreeStorageSpace"
    namespace = "AWS/ES"
    period = "${each.value.alarm_free_storage_space_too_low_period}"
    statistic = "Maximum"
    threshold = "${each.value.free_storage_space_threshold}"
    alarm_description = "Minimum free disk space on a single node "
    alarm_actions = var.actions_alarm
    treat_missing_data = "ignore"

    dimensions = {
        domain_name = var.domain_name
        
    }

    tags = var.tags

  
}


resource "aws_cloudwatch_metric_alarm" "free_storage_space_total_too_low" {
    for_each = { for k, v in var.tfc_monitor_object : k => v if var.monitor_free_storage_space_total_too_low }
  # If the user specified how many nodes, and they want to create this alert (disabled by default)
  alarm_name          = "${each.value.prefix}OpenSearch-FreeStorageSpaceTotalTooLow"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_free_storage_space_total_too_low_periods}"
  datapoints_to_alarm = "${each.value.alarm_free_storage_space_total_too_low_periods}"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_free_storage_space_total_too_low_period}"
  statistic           = "Sum"
  threshold           = "${each.value.free_storage_space_total_threshold}"
  alarm_description   = "Total aggregate free disk space "
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
  
  }
}


resource "aws_cloudwatch_metric_alarm" "cluster_index_writes_blocked" {
    for_each = { for k , v in var.tfc_monitor_object : k => v if var.monitor_cluster_index_writes_blocked }
 # count               = var.monitor_cluster_index_writes_blocked ? 1 : 0
  alarm_name          = "${each.value.prefix}OpenSearch-ClusterIndexWritesBlocked"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_cluster_index_writes_blocked_periods}"
  datapoints_to_alarm = "${each.value.alarm_cluster_index_writes_blocked_periods}"
  metric_name         = "ClusterIndexWritesBlocked"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_cluster_index_writes_blocked_period}"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch index writes being blocker"
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}

resource "aws_cloudwatch_metric_alarm" "insufficient_available_nodes" {
    for_each = { for k , v in var.tfc_monitor_object : k => v if  var.monitor_min_available_nodes}
    alarm_name          = "${each.value.prefix}OpenSearch-InsufficientAvailableNodes"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "${each.value.alarm_min_available_nodes_periods}"
    datapoints_to_alarm = "${each.value.alarm_min_available_nodes_periods}"
    metric_name         = "Nodes"
    namespace           = "AWS/ES"
    period              = "${each.value.alarm_min_available_nodes_period}"
    statistic           = "Minimum"
    threshold           = "${each.value.min_available_nodes}"
    alarm_description   = "Elasticsearch nodes minimum available"
    alarm_actions       = var.actions_alarm
      # ok_actions          = [local.aws_sns_topic_arn]
    treat_missing_data  = "ignore"
    tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}

resource "aws_cloudwatch_metric_alarm" "automated_snapshot_failure" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if  var.monitor_automated_snapshot_failure}
 # count               = var.monitor_automated_snapshot_failure ? 1 : 0
  alarm_name          = "${each.value.prefix}OpenSearch-AutomatedSnapshotFailure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_automated_snapshot_failure_periods}"
  datapoints_to_alarm = "${each.value.alarm_automated_snapshot_failure_periods}"
  metric_name         = "AutomatedSnapshotFailure"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_automated_snapshot_failure_period}"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch automated snapshot failed"
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if  var.monitor_cpu_utilization_too_high}
  alarm_name          = "${each.value.prefix}OpenSearch-CPUUtilizationTooHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_cpu_utilization_too_high_periods}"
  datapoints_to_alarm = "${each.value.alarm_cpu_utilization_too_high_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_cpu_utilization_too_high_period}"
  statistic           = "Average"
  threshold           = "${each.value.cpu_utilization_threshold}"
  alarm_description   = "Average elasticsearch cluster CPU utilization high"
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}


resource "aws_cloudwatch_metric_alarm" "jvm_memory_pressure_too_high" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if var.monitor_jvm_memory_pressure_too_high }
 # count               = var.monitor_jvm_memory_pressure_too_high ? 1 : 0
  alarm_name          = "${each.value.prefix}Opensearch-JVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_jvm_memory_pressure_too_high_periods}"
  datapoints_to_alarm = "${each.value.alarm_jvm_memory_pressure_too_high_periods}"
  metric_name         = "JVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_jvm_memory_pressure_too_high_period}"
  statistic           = "Maximum"
  threshold           = "${each.value.jvm_memory_pressure_threshold}"
  alarm_description   = "Elasticsearch JVM memory pressure is High"
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
   
  }
}


resource "aws_cloudwatch_metric_alarm" "master_cpu_utilization_too_high" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if var.monitor_master_cpu_utilization_too_high }
  alarm_name          = "${each.value.prefix}OpenSearch-MasterCPUUtilizationTooHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_master_cpu_utilization_too_high_periods}"
  datapoints_to_alarm = "${each.value.alarm_master_cpu_utilization_too_high_periods}"
  metric_name         = "MasterCPUUtilization"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_master_cpu_utilization_too_high_period}"
  statistic           = "Average"
  threshold           = "${each.value.master_cpu_utilization_threshold}"
  alarm_description   = "Average elasticsearch cluster master CPU utilization High "
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}

resource "aws_cloudwatch_metric_alarm" "master_jvm_memory_pressure_too_high" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if var.monitor_master_cpu_utilization_too_high }
  alarm_name          = "${each.value.prefix}OpenSearch-MasterJVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_master_jvm_memory_pressure_too_high_periods}"
  datapoints_to_alarm = "${each.value.alarm_master_jvm_memory_pressure_too_high_periods}"
  metric_name         = "MasterJVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_master_jvm_memory_pressure_too_high_period}"
  statistic           = "Maximum"
  threshold           = "${each.value.master_jvm_memory_pressure_threshold}"
  alarm_description   = "Elasticsearch JVM Master memory pressure is High"
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}

resource "aws_cloudwatch_metric_alarm" "kms_key_error" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if var.monitor_kms }
  alarm_name          = "${each.value.prefix}OpenSearch-KMSKeyError"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_kms_periods}"
  datapoints_to_alarm = "${each.value.alarm_kms_periods}"
  metric_name         = "KMSKeyError"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_kms_period}"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch KMS Key Error failed "
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}

resource "aws_cloudwatch_metric_alarm" "kms_key_inaccessible" {
  for_each = { for k , v in var.tfc_monitor_object : k => v if var.monitor_kms }
  alarm_name          = "${each.value.prefix}OpenSearch-KMSKeyInaccessible"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${each.value.alarm_kms_periods}"
  datapoints_to_alarm = "${each.value.alarm_kms_periods}"
  metric_name         = "KMSKeyInaccessible"
  namespace           = "AWS/ES"
  period              = "${each.value.alarm_kms_period}"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch KMS Key Inaccessible failed "
  alarm_actions       = var.actions_alarm
 # ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    
  }
}






# resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
#     for_each = { for k, v in var.tfc_monitor_object : k => v if var.create_high_cpu_alarm }
#     alarm_name          = "${each.value.prefix}rds-highCPUUtilization"
#     comparison_operator = "GreaterThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "CPUUtilization"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.cpu_utilization_too_high_threshold}"
#     alarm_description   = "Average database CPU utilization is too high."
#     alarm_actions       = var.actions_alarm
#    # ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }


# resource "aws_cloudwatch_metric_alarm" "cpu_credit_balance_too_low" {
#     for_each  =   { for k, v in var.tfc_monitor_object : k => v if var.create_low_cpu_credit_alarm || length(regexall("(t2|t3)", var.db_instance_class)) > 0 }
#     alarm_name = "${each.value.prefix}rds-lowCPUCreditBalance"
#     comparison_operator = "LessThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "CPUCreditBalance"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.cpu_credit_balance_too_low_threshold}"
#     alarm_description   = "Average database CPU credit balance is too low, a negative performance impact is imminent."
#     alarm_actions       = var.actions_alarm

#     dimensions = {
#      DBInstanceIdentifier = var.db_instance_id
#    }
#    tags = var.tags



  
# }

# // Disk Utilization
# resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
#     for_each = { for k, v in var.tfc_monitor_object : k => v if var.create_high_queue_depth_alarm }
    
#     #   for_each  =   { for k, v in var.tfc_vpc_object : k => v if var.vpc_enabled}

#     alarm_name          = "${each.value.prefix}rds-highDiskQueueDepth"
#     comparison_operator = "GreaterThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "DiskQueueDepth"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.disk_queue_depth_too_high_threshold}"
#     alarm_description   = "Average database disk queue depth is too high, performance may be negatively impacted."
#     alarm_actions       = var.actions_alarm
#  # ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }

# resource "aws_cloudwatch_metric_alarm" "disk_free_storage_space_too_low" {
#     for_each = { for k, v in var.tfc_monitor_object : k => v if var.create_low_disk_space_alarm }
#     alarm_name          = "${each.value.prefix}rds-lowFreeStorageSpace"
#     comparison_operator = "LessThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "FreeStorageSpace"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.disk_free_storage_space_too_low_threshold}"
#     alarm_description   = "Average database free storage space is too low and may fill up soon."
#     alarm_actions       = var.actions_alarm
#   #  ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }

# resource "aws_cloudwatch_metric_alarm" "disk_burst_balance_too_low" {
#     for_each = {for k , v in var.tfc_monitor_object : k => v if var.create_low_disk_burst_alarm }
#  # count               = var.create_low_disk_burst_alarm ? 1 : 0
#    alarm_name          = "${each.value.prefix}rds-lowEBSBurstBalance"
#    comparison_operator = "LessThanThreshold"
#    evaluation_periods  = "${each.value.evaluation_period}"
#    metric_name         = "BurstBalance"
#    namespace           = "AWS/RDS"
#    period              = "${each.value.statistic_period}"
#    statistic           = "Average"
#    threshold           = "${each.value.disk_burst_balance_too_low_threshold}"
#    alarm_description   = "Average database storage burst balance is too low, a negative performance impact is imminent."
#    alarm_actions       = var.actions_alarm
#   # ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }

# // Memory Utilization
# resource "aws_cloudwatch_metric_alarm" "memory_freeable_too_low" {
#     for_each = {for k, v in var.tfc_monitor_object : k => v if var.create_low_memory_alarm }
#     alarm_name          = "${each.value.prefix}rds-lowFreeableMemory"
#     comparison_operator = "LessThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "FreeableMemory"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.memory_freeable_too_low_threshold}"
#     alarm_description   = "Average database freeable memory is too low, performance may be negatively impacted."
#     alarm_actions       = var.actions_alarm
#   #  ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }

# resource "aws_cloudwatch_metric_alarm" "memory_swap_usage_too_high" {
#     for_each = {for k, v in var.tfc_monitor_object : k => v if var.create_swap_alarm }
#     alarm_name          = "${each.value.prefix}rds-highSwapUsage"
#     comparison_operator = "GreaterThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "SwapUsage"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.memory_swap_usage_too_high_threshold}"
#     alarm_description   = "Average database swap usage is too high, performance may be negatively impacted."
#     alarm_actions       = var.actions_alarm
#  # ok_actions          = var.actions_ok

#   dimensions = {
#     DBInstanceIdentifier = var.db_instance_id
#   }
#   tags = var.tags
# }


# // Connection Count
# resource "aws_cloudwatch_metric_alarm" "connection_count_anomalous" {
#     for_each = {for k, v in var.tfc_monitor_object : k => v if var.create_anomaly_alarm }
#     alarm_name          = "${each.value.prefix}rds-anomalousConnectionCount"
#     comparison_operator = "GreaterThanUpperThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     threshold_metric_id = "e1"
#     alarm_description   = "Anomalous database connection count detected. Something unusual is happening."
#     alarm_actions       = var.actions_alarm
#    # ok_actions          = var.actions_ok

#   metric_query {
#     id          = "e1"
#     expression  = "ANOMALY_DETECTION_BAND(m1, ${each.value.anomaly_band_width})"
#     label       = "DatabaseConnections (Expected)"
#     return_data = "true"
#   }

#   metric_query {
#     id          = "m1"
#     return_data = "true"
#     metric {
#       metric_name = "DatabaseConnections"
#       namespace   = "AWS/RDS"
#       period      = "${each.value.anomaly_period}"
#       stat        = "Average"
#       unit        = "Count"

#       dimensions = {
#         DBInstanceIdentifier = var.db_instance_id
#       }
#     }
#   }
#   tags = var.tags
# }

# resource "aws_cloudwatch_metric_alarm" "maximum_used_transaction_ids_too_high" {
#     for_each = var.tfc_monitor_object
#  # count               = contains(["aurora-postgresql", "postgres"], var.engine) ? 1 : 0
#     alarm_name          = "${each.value.prefix}rds-maximumUsedTransactionIDs"
#     comparison_operator = "GreaterThanThreshold"
#     evaluation_periods  = "${each.value.evaluation_period}"
#     metric_name         = "MaximumUsedTransactionIDs"
#     namespace           = "AWS/RDS"
#     period              = "${each.value.statistic_period}"
#     statistic           = "Average"
#     threshold           = "${each.value.maximum_used_transaction_ids_too_high_threshold}"
#     alarm_description   = "Nearing a possible critical transaction ID wraparound."
#     alarm_actions       = var.actions_alarm
#   #  ok_actions          = var.actions_ok
# }


