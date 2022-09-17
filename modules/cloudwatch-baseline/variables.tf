# variable "create_low_cpu_credit_alarm" {
#   type        = bool
#   default     = true
#   description = "Whether or not to create the low cpu credit alarm.  Default is to create it (for backwards compatible support)"
# }

# # variable "db_instance_class" {
# #   type      = string
# #   description = "The rds instance class, e.g. db.t3.medium"
# # }


variable "actions_alarm" {
  type        = list
  default     = []
  description = "A list of actions to take when alarms are triggered. Will likely be an SNS topic for event distribution."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to each alarm"
}

# variable "db_instance_id" {
#   type        = string
#   description = "RDS Instance ID"
# }

variable "monitor_cluster_status_is_red" {
  description = "Enable monitoring of cluster status is in red"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The Elasticsearch domain name you want to monitor"
  type        = string
}

variable "monitor_cluster_status_is_yellow" {
  description = "Enable monitoring of cluster status is in yellow"
  type        = bool
  default     = true
}

variable "monitor_free_storage_space_too_low" {
  description = "Enable monitoring of cluster per-node free storage is too low"
  type        = bool
  default     = true
}

variable "monitor_free_storage_space_total_too_low" {
  description = "Enable monitoring of cluster total free storage is too low.  Disabled by default, if you set this you must set free_storage_space_total_threshold also"
  type        = bool
  default     = false
}

variable "monitor_cluster_index_writes_blocked" {
  type = bool
  default = true

  
}

variable "monitor_min_available_nodes" {
  description = "Enable monitoring of minimum available nodes"
  type        = bool
  default     = true
}

variable "monitor_automated_snapshot_failure" {
  description = "Enable monitoring of automated snapshot failure"
  type        = bool
  default     = true
}

variable "monitor_cpu_utilization_too_high" {
  description = "Enable monitoring of CPU utilization is too high"
  type        = bool
  default     = true
}


variable "monitor_jvm_memory_pressure_too_high" {
  description = "Enable monitoring of JVM memory pressure is too high"
  type        = bool
  default     = true
}

variable "monitor_master_cpu_utilization_too_high" {
  description = "Enable monitoring of CPU utilization of master nodes are too high. Only enable this when dedicated master is enabled"
  type        = bool
  default     = false
}

# variable "monitor_master_cpu_utilization_too_high" {
#   description = "Enable monitoring of CPU utilization of master nodes are too high. Only enable this when dedicated master is enabled"
#   type        = bool
#   default     = false
# }

variable "monitor_kms" {
  description = "Enable monitoring of KMS-related metrics.  Only enable this when using KMS with ElasticSearch"
  type        = bool
  default     = true
}


variable "tfc_monitor_object" {
  type = map(object({
    prefix = string, 
   # evaluation_period = number,
    alarm_cluster_status_is_red_periods = number   
  #  statistic_period = number,
    alarm_cluster_status_is_red_period = number
    alarm_cluster_status_is_yellow_periods = number
    alarm_cluster_status_is_yellow_period = number
    alarm_free_storage_space_too_low_periods = number
    alarm_free_storage_space_too_low_period = number
    free_storage_space_threshold = number
    alarm_free_storage_space_total_too_low_periods = number
    alarm_free_storage_space_total_too_low_period= number
    alarm_cluster_index_writes_blocked_periods = number
    alarm_cluster_index_writes_blocked_period = number
    alarm_min_available_nodes_periods = number
    min_available_nodes = number
    alarm_min_available_nodes_period = number
    alarm_automated_snapshot_failure_periods = number
    alarm_automated_snapshot_failure_period = number
    alarm_cpu_utilization_too_high_periods = number
    alarm_cpu_utilization_too_high_period = number
    cpu_utilization_threshold = number
    alarm_jvm_memory_pressure_too_high_periods = number
    alarm_jvm_memory_pressure_too_high_period = number
    jvm_memory_pressure_threshold = number
    alarm_master_cpu_utilization_too_high_periods = number
    alarm_master_cpu_utilization_too_high_period = number
    master_cpu_utilization_threshold = number
    alarm_master_jvm_memory_pressure_too_high_periods = number
    alarm_master_jvm_memory_pressure_too_high_period = number
    master_jvm_memory_pressure_threshold = number
    alarm_kms_periods = number
    alarm_kms_period = number


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




# variable "create_high_cpu_alarm" {
#     type = bool
#     default = true
  
# }

# # variable "create_high_queue_depth_alarm" {
# #     type = bool
# #     default = true
  
# # }

# # variable "create_low_disk_space_alarm" {
# #     type = bool
# #     default = true
  
# # }

# # variable "create_low_disk_burst_alarm" {
# #     type = bool
# #     default = true  
# # }

# # variable "create_low_memory_alarm" {
# #     type = bool
# #     default = true
  
# # }

# # variable "create_swap_alarm" {
# #     type = bool
# #     default = true
  
# # }

# variable "create_anomaly_alarm" {
#     type = bool
#     default = true
  
# }