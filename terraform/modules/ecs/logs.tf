locals {
  tags = merge(var.tags, {
    Module = "ecs"
  })
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.log_retention_days

  tags = local.tags
}
