resource "aws_eip" "nat_gw_eip" {
  domain = "vpc" 
  
  tags = {
    Name = "homelab-3"
  }
}


resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.subnet-1-public.id

  tags = {
    Name = "homelab-3"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}