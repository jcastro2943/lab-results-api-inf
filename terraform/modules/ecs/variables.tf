variable "name" {
  description = "Name prefix for ECS resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN to register tasks with"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "ECS task role ARN"
  type        = string
}

variable "container_image" {
  description = "Container image URI (e.g. ECR repo URI with tag)"
  type        = string
}

variable "task_cpu" {
  description = "Fargate task CPU units"
  type        = number
  default     = 512
}

variable "task_memory" {
  description = "Fargate task memory (MiB)"
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Desired number of running tasks"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum tasks for autoscaling"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum tasks for autoscaling"
  type        = number
  default     = 10
}

variable "cpu_target_value" {
  description = "Target average CPU utilization % for autoscaling"
  type        = number
  default     = 60
}

variable "memory_target_value" {
  description = "Target average memory utilization % for autoscaling"
  type        = number
  default     = 70
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent during rolling deployments"
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "Maximum percent of desired count during rolling deployments"
  type        = number
  default     = 200
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days for application logs"
  type        = number
  default     = 30
}

variable "environment_variables" {
  description = "Plain-text environment variables for the container"
  type        = map(string)
  default     = {}
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights for enhanced task-level metrics"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
