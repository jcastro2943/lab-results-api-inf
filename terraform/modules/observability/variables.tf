variable "name" {
  description = "Name prefix for observability resources"
  type        = string
}

variable "aws_region" {
  description = "AWS region (used in dashboard widget definitions)"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the ALB, used as a CloudWatch metric dimension"
  type        = string
}

variable "target_group_arn_suffix" {
  description = "ARN suffix of the target group, used as a CloudWatch metric dimension"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "app_log_group_name" {
  description = "CloudWatch log group name for application logs"
  type        = string
}

variable "alarm_actions" {
  description = "ARNs to notify on alarm; if empty, an SNS topic is created from alarm_notification_emails"
  type        = list(string)
  default     = []
}

variable "alarm_notification_emails" {
  description = "Email addresses to subscribe to the alerting SNS topic"
  type        = list(string)
  default     = []
}

variable "http_5xx_threshold" {
  description = "Number of ALB target 5xx responses within the evaluation period that triggers the alarm"
  type        = number
  default     = 10
}

variable "http_5xx_evaluation_period_seconds" {
  description = "Period (seconds) over which 5xx errors are summed for the alarm"
  type        = number
  default     = 60
}

variable "http_5xx_evaluation_periods" {
  description = "Number of consecutive periods the threshold must be breached before alarming"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
