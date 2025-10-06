output "ALB_dns" {
  value = aws_lb.ALB.dns_name
  description = "The public DNS name of the Application Load Balancer"
}