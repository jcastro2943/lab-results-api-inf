resource "aws_cloudwatch_metric_alarm" "target_5xx" {
  alarm_name          = "${var.name}-alb-target-5xx-errors"
  alarm_description   = "Application (target) 5xx error count exceeded threshold"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_Target_5XX_Count"
  statistic           = "Sum"
  period              = var.http_5xx_evaluation_period_seconds
  evaluation_periods  = var.http_5xx_evaluation_periods
  threshold           = var.http_5xx_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  alarm_actions = local.alarm_targets
  ok_actions    = local.alarm_targets

  tags = local.tags
}

resource "aws_cloudwatch_metric_alarm" "elb_5xx" {
  alarm_name          = "${var.name}-alb-elb-5xx-errors"
  alarm_description   = "Load balancer-generated 5xx error count exceeded threshold"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  statistic           = "Sum"
  period              = var.http_5xx_evaluation_period_seconds
  evaluation_periods  = var.http_5xx_evaluation_periods
  threshold           = var.http_5xx_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = local.alarm_targets
  ok_actions    = local.alarm_targets

  tags = local.tags
}
