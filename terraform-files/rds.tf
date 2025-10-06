resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  db_name                = "mydb" 
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  username               = "foo"
  password               = "foobarbaz"

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  publicly_accessible    = false 
  multi_az               = true 

  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "db_subnets"
  subnet_ids = [
    aws_subnet.subnet-3-private.id,
    aws_subnet.subnet-4-private.id
  ]

  tags = {
    Name = "homelab_3"
  }
}