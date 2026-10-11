resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  } 
}
## here vpc name is my-vpc and vpc id is aws_vpc.dev.id