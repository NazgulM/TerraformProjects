provider "aws" {
  region = var.region
}

resource "aws_default_vpc" "default" {
}
resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"
}
resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1b"
}
resource "aws_default_subnet" "default_az3" {
  availability_zone = "us-east-1c"
}
resource "aws_default_subnet" "default_az4" {
  availability_zone = "us-east-1d"
}
resource "aws_security_group" "wordpress" {
  name        = "allow http and https traffic into wordpress"
  description = "allows web traffic both inbound and outbound"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    description = "Https"
    from_port   = 80
    to_port     = 80
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
resource "aws_elb" "wordpress" {
  name            = "wordpress-elb"
  subnets         = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id, aws_default_subnet.default_az3.id, aws_default_subnet.default_az4.id]
  security_groups = [aws_security_group.wordpress.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress"
  image_id      = var.image_id
  instance_type = var.instance_type
}
resource "aws_autoscaling_group" "wordpress" {
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  launch_template {
    id      = aws_launch_template.wordpress.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_attachment" "wordpress" {
  autoscaling_group_name = aws_autoscaling_group.wordpress.id
  elb                    = aws_elb.wordpress.id
}