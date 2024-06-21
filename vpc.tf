resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name        = "${var.vpc_name}"
    Environment = "${terraform.workspace}"
  }
}