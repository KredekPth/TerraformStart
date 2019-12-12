resource "aws_security_group" "ALB-SG" {
    name = "ALB-SG"
    vpc_id = "${aws_vpc.ChaosGears.id}"

}
resource "aws_security_group" "APPLICATION-SG" {
    name = "APPLICATION-SG"
    vpc_id = "${aws_vpc.ChaosGears.id}"
}

resource "aws_security_group" "BASTION-SG" {
    name = "BASTION-SG"
    vpc_id = "${aws_vpc.ChaosGears.id}"
}

resource "aws_security_group_rule" "AllowAllHTTP" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ALB-SG.id}"
}

resource "aws_security_group_rule" "AllowFromLBHTTP" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.APPLICATION-SG.id}"
  source_security_group_id = "${aws_security_group.ALB-SG.id}"
}

resource "aws_security_group_rule" "AllowFromBastionHTTP" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.APPLICATION-SG.id}"
  source_security_group_id = "${aws_security_group.BASTION-SG.id}"

}

resource "aws_security_group_rule" "AllowFromWorldToBastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = "${aws_security_group.BASTION-SG.id}"
  cidr_blocks = ["0.0.0.0/0"]
}