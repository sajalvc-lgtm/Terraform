module "dev" {
    source = "../Day-6-ec2-modules/"
    ami_id = "ami-097855b862d5b1eb2"
    instance_type = "t2.medium"
    az = "us-east-1b"
  
  
}
