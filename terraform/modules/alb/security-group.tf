resource "aws_security_group" "alb" {
  name        = "${var.name}-alb-sg"
  description = "Controls access to the Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${var.name}-alb-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  count = local.use_https ? 1 : 0

  security_group_id = aws_security_group.alb.id
  description        = "Allow inbound HTTPS from allowed clients"
  cidr_ipv4          = var.alb_ingress_cidrs[0]
  from_port          = 443
  to_port            = 443
  ip_protocol        = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https_extra" {
  for_each = local.use_https ? toset(slice(var.alb_ingress_cidrs, 1, length(var.alb_ingress_cidrs))) : toset([])

  security_group_id = aws_security_group.alb.id
  description        = "Allow inbound HTTPS from allowed clients"
  cidr_ipv4          = each.value
  from_port          = 443
  to_port            = 443
  ip_protocol        = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.alb.id
  description        = local.use_https ? "Allow inbound HTTP for redirect to HTTPS" : "Allow inbound HTTP from allowed clients"
  cidr_ipv4          = var.alb_ingress_cidrs[0]
  from_port          = 80
  to_port            = 80
  ip_protocol        = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "http_extra" {
  for_each = toset(slice(var.alb_ingress_cidrs, 1, length(var.alb_ingress_cidrs)))

  security_group_id = aws_security_group.alb.id
  description        = local.use_https ? "Allow inbound HTTP for redirect to HTTPS" : "Allow inbound HTTP from allowed clients"
  cidr_ipv4          = each.value
  from_port          = 80
  to_port            = 80
  ip_protocol        = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "to_ecs_tasks" {
  security_group_id = aws_security_group.alb.id
  description        = "Allow outbound traffic to ECS tasks on the container port within the VPC"
  cidr_ipv4          = var.vpc_cidr
  from_port          = var.container_port
  to_port            = var.container_port
  ip_protocol        = "tcp"
}
