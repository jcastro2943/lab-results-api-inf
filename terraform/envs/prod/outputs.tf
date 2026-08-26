output "alb_dns_name" {
  description = "Public DNS name of the ALB — point your domain's CNAME/ALIAS here"
  value       = module.alb.alb_dns_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs.service_name
}

output "dashboard_url" {
  description = "URL to the CloudWatch dashboard"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${module.observability.dashboard_name}"
}

output "alerts_sns_topic_arn" {
  description = "SNS topic ARN receiving 5xx alarm notifications"
  value       = module.observability.sns_topic_arn
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_execution.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task.arn
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}

output "github_actions_ci_role_arn" {
  description = "ARN of the role GitHub Actions assumes via OIDC to push to ECR"
  value       = var.github_repository != "" ? aws_iam_role.github_actions_ci[0].arn : null
}

output "ecs_task_definition_family" {
  description = "ECS task definition family name"
  value       = module.ecs.task_definition_family
}

output "container_name" {
  description = "Main container name inside the task definition"
  value       = module.ecs.container_name
}
