resource "aws_instance" "webserver" {
  ami = "ami-0efc43a4067fe9a3e"
  instance_type = "t2.micro"
  tags = {
    name = "First EC2"
  }
}