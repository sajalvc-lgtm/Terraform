resource "aws_instance" "name" {
    ami = "ami-01edba92f9036f76e"
    instance_type = "t2.medium"
    tags = {
        Name = "server-1"
          }
    
  
}

resource "aws_s3_bucket" "name" {
    bucket = "veera-nit-dev-test"
  
}

resource "aws_s3_bucket_versioning" "example_versioning" {
  bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  }
}
  


#terraform import 
# terraform import aws_instance.name i-06bbd023a433c869f