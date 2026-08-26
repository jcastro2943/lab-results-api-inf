variable "name" {
  description = "Name prefix for ALB resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB (must span >= 2 AZs)"
  type        = list(string)
}

variable "container_port" {
  description = "Port the ECS tasks listen on (target group target port)"
  type        = number
  default     = 8080
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener; empty falls back to HTTP-only"
  type        = string
  default     = ""
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection on the ALB"
  type        = bool
  default     = false
}

variable "access_logs_prefix" {
  description = "S3 key prefix for ALB access logs"
  type        = string
  default     = "alb-access-logs"
}

variable "access_logs_retention_days" {
  description = "Number of days to retain ALB access logs in S3 before expiration"
  type        = number
  default     = 90
}

variable "alb_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the ALB (public internet by default)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_cidr" {
  description = "VPC CIDR block, used to scope the ALB egress rule"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
