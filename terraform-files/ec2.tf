locals {
  private_subnets = [
    aws_subnet.subnet-3-private.id, 
    aws_subnet.subnet-4-private.id
  ]
}

resource "aws_key_pair" "main" {
  key_name   = "homelab-3-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "my_ec2_lab" {
    count = 2

    ami = var.ami
    instance_type = "t2.micro"
    subnet_id = local.private_subnets[count.index]
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
    associate_public_ip_address = false

    key_name = aws_key_pair.main.key_name


    user_data = <<-EOF
              #!/bin/bash
              # Update system and install nginx (used here as a simple mock application)
              sudo apt update -y
              sudo apt install -y nginx

              # Configure Nginx to listen on port 8080 (the application port expected by the ALB)
              sudo sed -i 's/listen 80 default_server;/listen 8080 default_server;/g' /etc/nginx/sites-enabled/default
              sudo sed -i 's/listen \[::\]:80 default_server;/listen \[::\]:8080 default_server;/g' /etc/nginx/sites-enabled/default

              # Set a simple message for testing
              echo "<h1>Hello from Homelab Instance ${count.index + 1} on Port 8080!</h1>" | sudo tee /var/www/html/index.nginx-debian.html
              
              # Restart Nginx to apply the new port 8080 configuration
              sudo systemctl restart nginx
              EOF

    tags = {
    # Use count.index to give each instance a unique name
        Name = "homelab_3-EC2-Instance-${count.index + 1}"
    }
}