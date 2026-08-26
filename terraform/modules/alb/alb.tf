locals {
  tags = merge(var.tags, {
    Module = "alb"
  })
  use_https = var.certificate_arn != ""
}

resource "aws_lb" "this" {
  name                       = "${var.name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  drop_invalid_header_fields = true

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.id
    prefix  = var.access_logs_prefix
    enabled = true
  }

  tags = merge(local.tags, {
    Name = "${var.name}-alb"
  })

  depends_on = [
    aws_s3_bucket_policy.alb_logs
  ]
}
