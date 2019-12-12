resource "aws_instance" "bastion" { 
    ami = "${var.amis}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.BASTION-SG.id}"]
    subnet_id = "${aws_subnet.ChaosGears-Public-1a.id}"
    associate_public_ip_address = true
    tags = {
        Name="BASTION"
    }
}

resource "aws_instance" "application" { 
    ami = "${var.amis}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.APPLICATION-SG.id}"]
    subnet_id = "${aws_subnet.ChaosGears-Private-1a.id}"
        tags = {
        Name="VeryImportantBackendService"
    }
}