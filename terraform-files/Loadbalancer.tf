resource "aws_lb" "ALB" {
  name               = "ALB-homelab"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
  aws_subnet.subnet-1-public.id,
  aws_subnet.subnet-2-public.id
  ]
  enable_deletion_protection = false

  tags = {
    Environment = "homelab_3"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}


resource "aws_lb_target_group" "alb-target-group" {
  name        = "ALB-target-group"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/"   
    port                = "8080"    # Check the root path of the application
    protocol            = "HTTP"
    matcher             = "200"     # Expect a successful HTTP 200 response
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
  }
}


# This resource attaches the first EC2 instance (index 0) to the Target Group.
resource "aws_lb_target_group_attachment" "nginx_attachment_0" {
  # Reference to the ARN of the previously defined Target Group.
  target_group_arn = aws_lb_target_group.alb-target-group.arn 
  
  # References the ID of the first instance created by the 'my_ec2_lab' count block.
  target_id        = aws_instance.my_ec2_lab[0].private_ip
  port             = 8080 
}

# This resource attaches the second EC2 instance (index 1) to the Target Group.
resource "aws_lb_target_group_attachment" "nginx_attachment_1" {
  # Reference to the ARN of the previously defined Target Group.
  target_group_arn = aws_lb_target_group.alb-target-group.arn 
  
  # References the ID of the second instance created by the 'my_ec2_lab' count block.
  target_id        = aws_instance.my_ec2_lab[1].private_ip
  port             = 8080 
}