output "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.this.dashboard_name
}

output "sns_topic_arn" {
  description = "ARN of the alerting SNS topic"
  value       = local.create_topic ? aws_sns_topic.alerts[0].arn : null
}

output "target_5xx_alarm_arn" {
  description = "ARN of the target 5xx CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.target_5xx.arn
}

output "elb_5xx_alarm_arn" {
  description = "ARN of the ELB 5xx CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.elb_5xx.arn
}
