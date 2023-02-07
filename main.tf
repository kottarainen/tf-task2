terraform {
    required_providers {
      aws = {
        version = "~> 3.76.1"
        source = "hashicorp/aws"
      }
    }
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "ec2instance" {
    count = 2
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
    tags = {
	 Name = "task2instance-${count.index + 1}"
    }
    key_name = "keys-task2"

    user_data = file("${path.module}/userdata.tpl")
}

resource "aws_elb" "elb-task2" {
  name            = "elb-task2"
  #subnets         = [aws_instance.ec2instance[1].subnet_id]
  subnets = ["${aws_instance.ec2instance[0].subnet_id}", "${aws_instance.ec2instance[1].subnet_id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  #instances = [aws_instance.ec2instance[1].id]
  instances = ["${aws_instance.ec2instance[0].id}", "${aws_instance.ec2instance[1].id}"]
}