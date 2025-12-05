/* 
resource "aws_instance" "DBServer" {
  ami           = "ami-0c5204531f799e0c6" # Example AMI ID for us-west-2
  instance_type = "t2.micro"

  tags = {
    Name = "DBServer"
  }
} 
*/

resource "aws_instance" "WebServer" {
  ami           = "ami-0d593311db5abb72b"
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer"
  }
  # associate_public_ip_address = true

  user_data = file("user-data.sh")

  security_groups = [aws_security_group.WebSG.name]
}


resource "aws_eip" "WebIP" {
  instance = aws_instance.WebServer.id
}

 
resource "aws_security_group" "WebSG" {
  description = "Allow inbound web traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      description = "Allow HTTP web traffic"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


}
