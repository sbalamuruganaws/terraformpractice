resource "aws_instance" "webserver" {
  ami = "ami-0efc43a4067fe9a3e"
  instance_type = "t2.micro"
  key_name = "lenovo"
  subnet_id = aws_subnet.sbpublic.id
  tags = {
    name = "First EC2"
  }
}

resource "aws_vpc" "sbvpc" {
  cidr_block = "10.20.30.0/24"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  
  tags = {
    name = "Managed by Terraform. Don't Edit manually"
  }
}

resource "aws_subnet" "sbpublic" {
  vpc_id = aws_vpc.sbvpc.id
  availability_zone = "us-east-2a"
  cidr_block = "10.20.30.0/26"
    tags = {
    name = "Managed by Terraform. Don't Edit manually"
  }
}

resource "aws_subnet" "sbprivate1" {
  vpc_id = aws_vpc.sbvpc.id
  cidr_block = "10.20.30.64/26" 
  tags = {
    name = "Managed by Terraform. Don't Edit manually"
  }
}

resource "aws_subnet" "sbprivate2" {
  vpc_id =  aws_vpc.sbvpc.id
  cidr_block = "10.20.30.128/26"
  tags = {
    name = "Managed by Terraform. Don't Edit manually"
  }
}

resource "aws_internet_gateway" "sbigw" {
  vpc_id = aws_vpc.sbvpc.id
  tags = {
    name = "Managed by Terraform. Don't Edit manually"
  }
}

resource "aws_route_table" "sbmainrt" {
  vpc_id = aws_vpc.sbvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sbigw.id
  }
}

resource "aws_route_table" "sbprirt" {
  vpc_id = aws_vpc.sbvpc.id
  tags = {
    name = "Managed by Terraform. Don't Edit manually"
  }
}

resource "aws_route_table_association" "sbassociate" {
  subnet_id = aws_subnet.sbpublic.id
  route_table_id = aws_route_table.sbmainrt
}

resource "aws_route_table_association" "sbpriassociate" {
  subnet_id = aws_subnet.sbprivate1.id
  route_table_id = aws_route_table.sbprirt
}