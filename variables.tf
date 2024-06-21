# Declare variables and their types.

variable "region" {
  default = "ap-south-1"
  type    = string
}

variable "cidr_block" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_image" {
  type = string
}

variable "prefix" {
  default = "s3-test-bucket"
  type    = string
}