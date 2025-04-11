output "security_group_id" {
  description = "ID of secuity group"
  value       = aws_security_group.security_group.id
}

output "ingress_rules" {
  value = [for i, v in aws_security_group_rule.ingress_rules : {desc = v.description, port = v.from_port}]
}

output "egress_rules" {
  value = [for m, n in aws_security_group_rule.egress_rules : {desc = n.description, port = n.from_port}]
}