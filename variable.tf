#-------create varible for vpc-------#
variable "aws_region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
    type = "list"
    default = ["10.0.1.0/24","10.0.2.0/24"]
  
}
variable "private_subnet_cidr" {
    type = "list"
    default = ["10.0.3.0/24","10.0.4.0/24"]
  
}
variable "azs" {
  type = "list"
  default =["us-east-1a","us-east-1b"]
  
}
####    ec2  #####
variable "aws_amis" {
  default ={
     us-east-1 = "ami-0080e4c5bc078760e"
     us-east-2 ="ami-0de53d8956e8dcf80 "
  }
  
}
