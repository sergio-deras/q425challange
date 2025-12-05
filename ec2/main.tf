resource "aws_instance" "myec2" {
  ami             = "ami-0c5204531f799e0c6" # Example AMI ID for us-west-2
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.traffic.name]
}

resource "aws_eip" "myeip" {
  instance = aws_instance.myec2.id
}


resource "aws_security_group" "traffic" {
  name        = "custom_traffic_sg"
  description = "Security group with custom ingress and egress rules"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrule
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrule
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

/* resource "aws_security_group" "mysg" {
    name        = "allow_ssh"
    description = "Allow SSH inbound traffic"

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
} */