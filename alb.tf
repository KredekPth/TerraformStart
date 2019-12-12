resource "aws_lb" "mainALB"{
    
    name = "ChaosGears-ALB"
    internal = false
    load_balancer_type = "application"
    security_groups = ["${aws_security_group.ALB-SG.id}"]
    subnets = ["${aws_subnet.ChaosGears-Public-1a.id}", "${aws_subnet.ChaosGears-Public-1b.id}"]
    enable_deletion_protection = false
        
}

resource "aws_lb_listener" "mainALB" {
  load_balancer_arn = "${aws_lb.mainALB.arn}"
  port  = "80"
  protocol = "HTTP"

  default_action {
      type = "forward"
      target_group_arn = "${aws_lb_target_group.mainALB.arn}"
  }
}


resource "aws_lb_target_group" "mainALB" {
    name = "ChaosGeras-ALB-TG"
    port = 80
    protocol = "HTTP"
    vpc_id = "${aws_vpc.ChaosGears.id}"

}

resource "aws_lb_target_group_attachment" "mainALB" {
    target_group_arn = "${aws_lb_target_group.mainALB.arn}"
    target_id = "${aws_instance.application.id}"
    port = 80
}
