resource "aws_launch_template" "insurance_lt" {
  name_prefix   = "insurance-lt-"
  image_id      = var.app_ami
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  iam_instance_profile {
    name = aws_iam_instance_profile.insurance_profile.name
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.instance_sg.id]
  }

  user_data = base64encode(file("user-data.sh")) # optional script
}

resource "aws_autoscaling_group" "insurance_asg" {
  name                      = "insurance-asg"
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 60
  vpc_zone_identifier       = var.public_subnet_ids
  target_group_arns         = [aws_lb_target_group.insurance_tg.arn]
  launch_template {
    id      = aws_launch_template.insurance_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "insurance-ec2"
    propagate_at_launch = true
  }
}
