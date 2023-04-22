resource "aws_instance" "wordpress" {
  ami               = "ami-07aff4aec26082ed9"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
}


resource "aws_security_group" "instance" {
  name = "wordpress-instance"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


