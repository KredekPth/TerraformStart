/*
VPC CREATE
*/
resource "aws_vpc" "ChaosGears" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
}
/*
IGW CREATE
*/
resource "aws_internet_gateway" "ChaosGears" {
    vpc_id = "${aws_vpc.ChaosGears.id}"
}

/*
PUBLIC-SUBNET & ROUTE TABLE CREATE
*/

resource "aws_subnet" "ChaosGears-Public-1a" {
  vpc_id = "${aws_vpc.ChaosGears.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "ChaosGears-Public-1b" {
  vpc_id = "${aws_vpc.ChaosGears.id}"
  cidr_block = "${var.public_subnet_cidr_b}"
  availability_zone = "eu-west-1b"
}

resource "aws_route_table" "ChaosGears-RT-Public-1a" {
  vpc_id = "${aws_vpc.ChaosGears.id}"
  route{
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.ChaosGears.id}"
  }
}

resource "aws_route_table" "ChaosGears-RT-Public-1b" {
  vpc_id = "${aws_vpc.ChaosGears.id}"
  route{
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.ChaosGears.id}"
  }
}

resource "aws_route_table_association" "ChaosGears-RTA-Public-1a" {
  subnet_id = "${aws_subnet.ChaosGears-Public-1a.id}"
  route_table_id = "${aws_route_table.ChaosGears-RT-Public-1a.id}"
}

resource "aws_route_table_association" "ChaosGears-RTA-Public-1b" {
  subnet_id = "${aws_subnet.ChaosGears-Public-1b.id}"
  route_table_id = "${aws_route_table.ChaosGears-RT-Public-1b.id}"
}

/*
PRIVATE-SUBNET & ROUTE TABLE CREATE
*/

resource "aws_subnet" "ChaosGears-Private-1a" {
  vpc_id = "${aws_vpc.ChaosGears.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1a"

}

resource "aws_subnet" "ChaosGears-Private-1b" {
  vpc_id = "${aws_vpc.ChaosGears.id}"
  cidr_block = "${var.private_subnet_cidr_b}"
  availability_zone = "eu-west-1b"

}

