resource "aws_security_group" "saurabhlg" {
    name="saurabhsg"
    vpc_id ="${aws_vpc.saurabhvpc.id}"

####inbound
    ingress {
        from_port=80
        to_port =80
        protocol = "tcp"
        cidr_blocks=["0.0.0.0/0"]
}
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
}
}   
resource "aws_elb" "saurabhlb" {
    name ="saurabhlb"
    subnets = ["${aws_subnet.saurabhpublicsubnet.*.id}"]
    security_groups =["${aws_security_group.saurabhlg.id}"]
    instances =[
    "${aws_instance.saurabhwebserver.id}",
    "${aws_instance.saurabhwebserver2.id}"

    ]
    listener{
        instance_port =80
        instance_protocol ="http"
        lb_port =80
        lb_protocol ="http"
    }
    health_check =[{
        target = "HTTP:80/"
        interval = 30
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout =5
    }]
}
