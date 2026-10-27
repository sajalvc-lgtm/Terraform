provider "aws" {
    profile = dev
    alias = "dev-account"
    region = "us-east-1"
  
}
provider "aws" {
    profile = test
    alias = "test-account"
    region = "us-west-2"
  
}

#before we have integrate the accounts 

aws configure --profile dev-account
aws configure --profile dev