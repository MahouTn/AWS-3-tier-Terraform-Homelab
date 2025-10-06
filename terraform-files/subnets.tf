resource "aws_subnet" "subnet-1-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "homelab-3"
  }
}

resource "aws_subnet" "subnet-2-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"

  tags = {
    Name = "homelab-3"
  }
}

resource "aws_subnet" "subnet-3-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "homelab-3"
  }
}

resource "aws_subnet" "subnet-4-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "homelab-3"
  }
}