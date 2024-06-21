resource "aws_key_pair" "mykey" {
  key_name   = "my-terraform-key"
  public_key = file("public_key.txt")

  tags = {
    Name = "terraform-key"
  }
}