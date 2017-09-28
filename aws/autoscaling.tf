resource "aws_launch_configuration" "launch-config" {
  security_groups = [ "${aws_security_group.webnode.id}" ]
  user_data = "${file("shared/user-data.txt")}"
  lifecycle { create_before_destroy = true }
  instance_type = "${var.instance_type}"
  image_id = "ami-26950f4f"
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = "webnode-asg"
  min_size = 1
  max_size = 3
  launch_configuration = "${aws_launch_configuration.launch-config.name}"
  default_cooldown = 60
  availability_zones = [ "${var.availability_zone_id}" ]

  tag {
    key = "Name"
    value = "webnode-soa"
    propagate_at_launch = true
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_policy" "autoscale_group_policy_up_x1" {
  name = "autoscale_group_policy_up_x1"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}

resource "aws_autoscaling_policy" "autoscale_group_policy_down_x1" {
  name = "autoscale_group_policy_down_x1"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}
