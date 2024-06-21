#locals {
#  ami_image = data.aws_ami.images.image_id
#}

#resource "aws_instance" "private-instance" {
#  ami             = var.ami_image
#  instance_type   = var.instance_type
#  key_name        = aws_key_pair.mykey.key_name
#  subnet_id       = aws_subnet.private-subnet.id
#  security_groups = ["${aws_security_group.private-sg.id}"]

#  tags = {
#    Name = "Private-instance"
#  }
#}


resource "aws_instance" "public-instance" {
  ami                         = var.ami_image
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.mykey.key_name
  subnet_id                   = aws_subnet.public-subnet[0].id
  security_groups             = [aws_security_group.elb-sg.id, aws_security_group.public-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.access-s3-profile.id
  associate_public_ip_address = true

  user_data = file("install-apache.sh")

  tags = {
    Name = "Public-instance"
  }
}

