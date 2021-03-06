resource "aws_elb" "nginx" {
  name            = "nginx"
  security_groups = ["${aws_security_group.load_balancers.id}"]
  subnets         = ["${aws_subnet.main.id}"]

  listener {
    lb_protocol = "http"
    lb_port     = 80

    instance_protocol = "http"
    instance_port     = 80
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing = true
}

resource "aws_ecs_task_definition" "nginx" {
  family                = "nginx"
  container_definitions = "${file("task-definitions/nginx.json")}"
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.nginx.arn}"
  iam_role        = "${aws_iam_role.ecs_service_role.arn}"
  desired_count   = 2
  depends_on      = ["aws_iam_role_policy.ecs_service_role_policy"]

  load_balancer {
    elb_name       = "${aws_elb.nginx.id}"
    container_name = "nginx"
    container_port = 80
  }
}
