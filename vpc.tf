#----create vpc----#
resource "aws_vpc" "saurabhvpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "saurabhvpc"
    }
  
}
#########one resource reffer another resourece#####
######### public subnet########
resource "aws_internet_gateway" "saurabhigw" {
  vpc_id ="${aws_vpc.saurabhvpc.id}"
  tags {
      Name ="saurabhIGW"
  }
}
####public subnet######
resource "aws_subnet" "saurabhpublicsubnet" {
    
   vpc_id ="${aws_vpc.saurabhvpc.id}"
   count ="${length(var.public_subnet_cidr)}"
   cidr_block ="${element(var.public_subnet_cidr, count.index)}"
   availability_zone = "${element(var.azs,count.index)}"
   tags {
    Name = "saurabhpublicsubnet-${count.index+1}"
}
map_public_ip_on_launch=true
}
###create public route table:define route forr ig####
resource "aws_route_table" "saurabhpublicroutetable" {
  vpc_id = "${aws_vpc.saurabhvpc.id}"
  route{
      cidr_block="0.0.0.0/0"
      gateway_id ="${aws_internet_gateway.saurabhigw.id}"
  }
  tags {
      Name ="saurabhroutetable"
  }

}

##################public route table asso################
resource "aws_route_table_association" "saurabhpublicroutetableassociation" {
     count ="${length(var.public_subnet_cidr)}"
     subnet_id ="${element(aws_subnet.saurabhpublicsubnet.*.id, count.index)}"
     route_table_id ="${aws_route_table.saurabhpublicroutetable.id}"
     
  
}
####private subnet####
resource "aws_subnet" "saurabhprivatesubnet" {
   
    
   vpc_id ="${aws_vpc.saurabhvpc.id}"
   count ="${length(var.private_subnet_cidr)}"
   cidr_block ="${element(var.private_subnet_cidr, count.index)}"
   availability_zone = "${element(var.azs,count.index)}"
   tags {
    Name = "saurabhprivatesubnet-${count.index+1}"
}
map_public_ip_on_launch=true
}
####private route table#######
  resource "aws_route_table" "saurabhroutetable" {
  vpc_id = "${aws_vpc.saurabhvpc.id}"
  
  tags {
      Name ="saurabhroutetable"
  }
}
#####private route table ass#####
resource "aws_route_table_association" "saurabhroutetableassociation" {
     count ="${length(var.private_subnet_cidr)}"
     subnet_id ="${element(aws_subnet.saurabhprivatesubnet.*.id, count.index)}"
     route_table_id ="${aws_route_table.saurabhroutetable.id}"
     
  
}





#####if we used single subnet syntax ########
#######avalability_zone = "${var.azs}"############
