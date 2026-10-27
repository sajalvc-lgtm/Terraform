module "dev" {
    source ="../day-9-Modules-ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    tags = var.tags
    #module variable = local variable 
  
}