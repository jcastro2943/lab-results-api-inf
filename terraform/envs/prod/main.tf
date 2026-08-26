locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source = "../../modules/vpc"

  name                 = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  single_nat_gateway   = false

  tags = local.common_tags
}

module "alb" {
  source = "../../modules/alb"

  name                       = local.name_prefix
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr                   = module.vpc.vpc_cidr
  public_subnet_ids          = module.vpc.public_subnet_ids
  container_port             = var.container_port
  certificate_arn            = var.certificate_arn
  enable_deletion_protection = false

  tags = local.common_tags
}

module "ecs" {
  source = "../../modules/ecs"

  name               = local.name_prefix
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_image = var.container_image
  container_port  = var.container_port
  task_cpu        = var.task_cpu
  task_memory     = var.task_memory
  desired_count   = var.desired_count
  min_capacity    = var.min_capacity
  max_capacity    = var.max_capacity

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent

  environment_variables = var.environment_variables

  tags = local.common_tags
}

module "observability" {
  source = "../../modules/observability"

  name       = local.name_prefix
  aws_region = var.aws_region

  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs.service_name
  app_log_group_name      = module.ecs.app_log_group_name

  alarm_notification_emails = var.alarm_notification_emails
  http_5xx_threshold        = var.http_5xx_threshold

  tags = local.common_tags
}
