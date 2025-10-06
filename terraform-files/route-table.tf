resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.internet
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "homelab-3"
  }
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.internet
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "homelab-3"
  }
}


resource "aws_route_table_association" "public_subnet_route_1" {
  subnet_id      = aws_subnet.subnet-1-public.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public_subnet_route_2" {
  subnet_id      = aws_subnet.subnet-2-public.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private_subnet_route_3" {
  subnet_id      = aws_subnet.subnet-3-private.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "private_subnet_route_4" {
  subnet_id      = aws_subnet.subnet-4-private.id
  route_table_id = aws_route_table.main-private.id
}