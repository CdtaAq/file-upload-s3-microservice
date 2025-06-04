resource "aws_lb" "insurance_alb" {
  name               = "insurance-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "InsuranceALB"
  }
}

resource "aws_lb_target_group" "insurance_tg" {
  name     = "insurance-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/actuator/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "InsuranceTG"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.insurance_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.insurance_tg.arn
  }
}
