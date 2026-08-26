locals {
  tags = merge(var.tags, {
    Module = "observability"
  })

  create_topic  = length(var.alarm_actions) == 0
  alarm_targets = local.create_topic ? [aws_sns_topic.alerts[0].arn] : var.alarm_actions
}

resource "aws_sns_topic" "alerts" {
  count = local.create_topic ? 1 : 0
  name  = "${var.name}-alerts"

  tags = local.tags
}

resource "aws_sns_topic_subscription" "email" {
  for_each = local.create_topic ? toset(var.alarm_notification_emails) : toset([])

  topic_arn = aws_sns_topic.alerts[0].arn
  protocol  = "email"
  endpoint  = each.value
}
