resource  "aws_instance" "name"{
  ami = "ami-097855b862d5b1eb2"
  instance_type = "t2.medium"
  availability_zone = "us-east-1b"
  tags= {
    Name = "sajal"
  }
}
  resource "aws_s3" "allow_ssh" {
    name        = "allow_ssh"
    description = "Allow SSH inbound traffic"
  
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["
  
}

