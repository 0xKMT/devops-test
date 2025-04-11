# This module creates a security group in AWS with specified ingress and egress rules.
# The security group is used to control inbound and outbound traffic to AWS resources.
# The security group is created in a specified VPC and can have multiple ingress and egress rules based on the provided variables.
resource "aws_security_group" "security_group" {
  name          = var.sg_name
  description   = var.sg_description
  vpc_id = var.vpc_id
  tags   = merge(
    { "Name" = var.sg_name },
    var.tags,
  )
} 

resource "aws_security_group_rule" "ingress_rules" {
  count       = length(var.ingress_ports)  //Use the count variable to iterate over each port element
  type        = "ingress"
  from_port   = var.ingress_ports[count.index].port
  to_port     = var.ingress_ports[count.index].port
  protocol    = var.ingress_protocol
  cidr_blocks = ["${var.ingress_cidr}"]
  description = var.ingress_ports[count.index].description
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "egress_rules" {
  count       = length(var.egress_ports)  
  type        = "egress"
  from_port   = var.egress_ports[count.index].port
  to_port     = var.egress_ports[count.index].port
  protocol    = var.egress_protocol
  cidr_blocks = ["${var.egress_cidr}"]
  description = var.egress_ports[count.index].description
  security_group_id = aws_security_group.security_group.id
}
