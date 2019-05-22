resource "aws_security_group" "saurabhwebserver" {
    name ="saurabhwebserver"
    vpc_id ="${aws_vpc.saurabhvpc.id}"

    ####ssh acess from anywhere###
    ingress {
        from_port=22
        to_port =22
        protocol = "tcp"
        cidr_blocks=["0.0.0.0/0"]
}
    ingress {
        from_port=80
        to_port =80
        protocol = "tcp"
        cidr_blocks=["0.0.0.0/0"]
}
 egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_instance" "saurabhwebserver" {
    ami ="${lookup(var.aws_amis,var.aws_region)}"
    instance_type ="t2.micro"
    associate_public_ip_address = true
    user_data ="${file("installyesapache.sh")}"
    tags {
        Name ="saurabhwebserver"
    }
    subnet_id="${aws_subnet.saurabhpublicsubnet.*.id[0]}"
    vpc_security_group_ids =["${aws_security_group.saurabhwebserver.id}"]
    }
resource "aws_instance" "saurabhwebserver2" {
    ami ="${lookup(var.aws_amis,var.aws_region)}"
    instance_type ="t2.micro"
    associate_public_ip_address = true
    user_data ="${file("installapache.sh")}"
    tags {
        Name ="saurabhwebserver2"
    }
    subnet_id="${aws_subnet.saurabhpublicsubnet.*.id[1]}"
    vpc_security_group_ids =["${aws_security_group.saurabhwebserver.id}"]
    }


