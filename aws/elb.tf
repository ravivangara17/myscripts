resource "aws_elb" "webnode" {
  name = "webnode-elb"
  connection_draining = true

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    target = "HTTP:80/"
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 2
    interval = 5
  }

  availability_zones = ["us-east-1c"]
}
resource "aws_elb_attachment" "webnodeelb" {
  elb      = "${aws_elb.webnode.id}"
  instance = "${aws_instance.webnode1.id}"
}
