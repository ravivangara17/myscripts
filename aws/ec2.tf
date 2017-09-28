# Uncomment resources below and add required arguments.

resource "aws_security_group" "webnode" {
  name = "web-node"

  description = "Test security group."
}

resource "aws_security_group_rule" "ssh_ingress_access" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = "${aws_security_group.webnode.id}"
}

resource "aws_security_group_rule" "http_ingress_access" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = "${aws_security_group.webnode.id}"
}

resource "aws_instance" "webnode1" {
  instance_type =  "${var.instance_type}" 
  associate_public_ip_address = false
  user_data = "${file("shared/user-data.txt")}"
  security_groups  = [ "${aws_security_group.webnode.name}" ]
  tags {
    Name = "my-first-webnode"
  }
  ami = "ami-26950f4f"
  availability_zone = "${var.availability_zone_id}"
}

output "private_ip" { value = "${aws_instance.webnode1.private_ip}" }
output "public_ip"  { value = "${aws_instance.webnode1.public_ip}" }
output "availability_zone" { value = [ "${var.availability_zone_id}" ] }
output "autoscaling_group" { value = "${aws_autoscaling_group.autoscaling_group.name}" }
