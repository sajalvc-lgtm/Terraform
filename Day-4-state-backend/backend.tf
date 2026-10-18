terraform {
  backend "s3" {
    bucket = "dev-test-prod-sajal-nit"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
