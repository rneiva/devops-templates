output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "security_group_lb_id" {
  value = aws_security_group.main.id
}

output "lb_sg_id" {
  value = aws_security_group.main.id
}