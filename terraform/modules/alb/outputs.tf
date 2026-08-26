output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.this.arn
}

output "alb_arn_suffix" {
  description = "ARN suffix of the ALB, used for CloudWatch metric dimensions"
  value       = aws_lb.this.arn_suffix
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Route53 hosted zone ID of the ALB (for alias records)"
  value       = aws_lb.this.zone_id
}

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "listener_arn" {
  description = "ARN of the listener clients connect to (HTTPS or HTTP)"
  value       = local.use_https ? aws_lb_listener.https[0].arn : aws_lb_listener.http.arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "target_group_arn_suffix" {
  description = "ARN suffix of the target group, used for CloudWatch metric dimensions"
  value       = aws_lb_target_group.this.arn_suffix
}

output "access_logs_bucket_id" {
  description = "ID (name) of the S3 bucket storing ALB access logs"
  value       = aws_s3_bucket.alb_logs.id
}

output "access_logs_bucket_arn" {
  description = "ARN of the S3 bucket storing ALB access logs"
  value       = aws_s3_bucket.alb_logs.arn
}
