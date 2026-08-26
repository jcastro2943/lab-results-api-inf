variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name used to build resource name prefixes"
  type        = string
  default     = "lab-api"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Two availability zones to deploy into"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "container_image" {
  description = "Container image URI for the ECS task"
  type        = string
}

variable "container_port" {
  description = "Port the application container listens on"
  type        = number
  default     = 8080
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
  default     = ""
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
  description = "Initial desired ECS task count"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum ECS task count for autoscaling"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum ECS task count for autoscaling"
  type        = number
  default     = 10
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent during rolling ECS deployments"
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "Maximum percent of desired count during rolling ECS deployments"
  type        = number
  default     = 200
}

variable "environment_variables" {
  description = "Plain-text environment variables for the application container"
  type        = map(string)
  default     = {}
}

variable "alarm_notification_emails" {
  description = "Email addresses to notify on 5xx alarms"
  type        = list(string)
  default     = []
}

variable "http_5xx_threshold" {
  description = "5xx count threshold that triggers the alarm"
  type        = number
  default     = 10
}

variable "github_repository" {
  description = "GitHub repository OIDC Token"
  type        = string
  default     = ""
}
