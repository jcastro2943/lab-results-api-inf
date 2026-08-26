variable "name" {
  description = "Name prefix for all VPC resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones to deploy into (exactly 2 expected for this architecture)"
  type        = list(string)

  validation {
    condition     = length(var.azs) == 2
    error_message = "This architecture is designed for exactly two availability zones."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets, one per AZ"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets, one per AZ"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "If true, deploy a single shared NAT Gateway instead of one per AZ"
  type        = bool
  default     = false
}

variable "flow_logs_retention_days" {
  description = "Retention in days for VPC Flow Logs in CloudWatch"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
