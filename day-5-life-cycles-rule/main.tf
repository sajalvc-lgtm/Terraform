resource  "aws_instance" "name"{
  ami = "ami-097855b862d5b1eb2"
  instance_type = "t2.medium"
  availability_zone = "us-east-1b"
  tags= {
    Name = "sajal"
  }

  # lifecycle {
  #   ignore_changes = [
  #    tags,   ami,
  #     instance_type,
  #     availability_zone
  #   ]
  # }
#   lifecycle {
#   prevent_destroy = true
# }

lifecycle {
  create_before_destroy = true #it 's very imp concept 
}
}
