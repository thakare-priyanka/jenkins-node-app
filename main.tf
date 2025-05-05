provider "aws" {
  region = "us-east-1"  
}
 
resource "aws_instance" "node_app_instance" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
 
#   key_name = "your-key-name"  # optional: agar SSH access chahiye
 
  tags = {
    Name = "NodeJS-App-Instance"
  }
 
  user_data = file("scripts/setup.sh")  # Node.js + Hello App setup script
 
  vpc_security_group_ids = [aws_security_group.node_sg.id]
 
  associate_public_ip_address = true
}
 
resource "aws_security_group" "node_sg" {
  name        = "nodejs-sg"
  description = "Allow HTTP and SSH"
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
