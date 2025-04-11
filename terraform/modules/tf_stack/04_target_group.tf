# Create a listener for the ALB
# This listener listens for incoming traffic on the specified port and protocol
resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.load_balancer_arn #aws_lb.lb.arn
  port              = var.alb_port_listener
  protocol          = var.alb_protocol_listener
  ssl_policy        = var.alb_ssl_policy
  certificate_arn   = var.certificate_arn 
  default_action {
    type             = var.routing_action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = var.tags
}

# Create a target group for the ALB
# This target group is used to route requests to the registered targets (e.g., EC2 instances, IP addresses, etc.)
resource "aws_lb_target_group" "target_group" {
  name        = var.tg_name
  target_type = var.tg_type
  ip_address_type = var.tg_ip_address_type
  port     = var.tg_port_alb_listener
  protocol = var.tg_protocol_alb_listener
  vpc_id   = var.vpc_id
  protocol_version = var.tg_protocol_version
  health_check {
    # This block configures the health check settings for the target group
    # Health checks are used to determine the health of the targets in the target group
    # If a target fails the health check, it will be considered unhealthy and traffic will not be routed to it
    enabled             = var.tg_health_check_enabled
    healthy_threshold   = var.tg_healthy_threshold
    unhealthy_threshold = var.tg_unhealthy_threshold
    timeout             = var.tg_timeout
    interval            = var.tg_interval
    matcher             = var.tg_matcher
    path                = var.tg_health_check_path
    port                = var.tg_health_check_port
    protocol            = var.tg_health_check_protocol 
  }
  stickiness { 
    # This block configures the stickiness settings for the target group
    # Stickiness settings determine whether the load balancer should route requests from a client to the same target
    enabled = var.tg_stickiness_enabled
    type    = var.tg_stickiness_type
    cookie_duration = var.tg_cookie_duration
  }
  tags = var.tags
}