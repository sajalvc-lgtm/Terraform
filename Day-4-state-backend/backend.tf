terraform {
  backend "s3" {
    bucket = "dev-test-prod-sajal-nit"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    lock-file = true #s3 native locking support version 1.0.0 and above
  }
}
