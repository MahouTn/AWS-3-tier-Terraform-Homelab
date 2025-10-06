// security group for ALB ( application loadbalancer )

resource "aws_security_group" "alb_sg" {
  name        = "allow traffic on the loadbalancer"
  description = "Allow inbound traffic and outbound traffic to loadbalancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "homelab_3"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.internet
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.internet
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.internet
  ip_protocol       = "-1"
}


// security group for ec2

resource "aws_security_group" "ec2_sg" {
  name        = "allow traffic on the ec2"
  description = "Allow inbound traffic and outbound traffic to instance ec2"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "homelab_3"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic_from_alb" {
  security_group_id = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic_from_alb_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4 = var.internet
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_traffic_to_db" {
  security_group_id = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.db_sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "ec2_internet_all_outbound" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = var.internet
  ip_protocol       = "-1" # All protocols
  description       = "Allow all outbound traffic to the internet (via NAT GW)"
}
// security group for DATABASE

resource "aws_security_group" "db_sg" {
  name        = "allow traffic on the db"
  description = "Allow inbound traffic to Database"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "homelab_3"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic_from_ec2" {
  security_group_id = aws_security_group.db_sg.id
  referenced_security_group_id = aws_security_group.ec2_sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "db_all" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = var.internet
  ip_protocol       = "-1"
}