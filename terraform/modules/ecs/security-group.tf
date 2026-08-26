resource "aws_security_group" "ecs_tasks" {
  name        = "${var.name}-ecs-tasks-sg"
  description = "Controls access to ECS tasks running in private subnets"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {
    Name = "${var.name}-ecs-tasks-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "from_alb" {
  security_group_id           = aws_security_group.ecs_tasks.id
  description                  = "Allow inbound traffic from the ALB on the container port"
  referenced_security_group_id = var.alb_security_group_id
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "https_egress" {
  security_group_id = aws_security_group.ecs_tasks.id
  description        = "Allow HTTPS egress for ECR pulls, AWS API calls, and external dependencies via NAT"
  cidr_ipv4          = "0.0.0.0/0"
  from_port          = 443
  to_port            = 443
  ip_protocol        = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "dns_udp_egress" {
  security_group_id = aws_security_group.ecs_tasks.id
  description        = "Allow DNS resolution (UDP)"
  cidr_ipv4          = "0.0.0.0/0"
  from_port          = 53
  to_port            = 53
  ip_protocol        = "udp"
}
