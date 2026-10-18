terraform {
  backend "s3" {
    bucket = "dev-test-prod-sajal-nit"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    #use_lockfile = true #s3 native locking support version 1.0.0 and above
    dynamodb_table = "dev-test-prod-sajal-nit-lock1"
  }
}
