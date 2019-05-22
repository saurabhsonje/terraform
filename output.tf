output "elb_dns" {
  value = "${aws_elb.saurabhlb.dns_name}"
}
