provider "aws" {
  region = "us-east-1"
}
#creating vpc
resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
    tags = {
        Name = "demo-vpc"
    }
}
#creating subnet
resource "aws_subnet" "demo-subnet-public" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.0.0/17"
  availability_zone = "us-east-1a"
    tags = {
        Name = "demo-subnet-public"
    }
}
#creating subnet
resource "aws_subnet" "demo-subnet-private" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.128.0/17"
  availability_zone = "us-east-1b"
    tags = {
        Name = "demo-subnet-private"
    }
}
#creatinf route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.demo.id
    tags = {
        Name = "demo-public-rt"
    }
}
# internet gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo.id
    tags = {
        Name = "demo-igw"
    }
}
#creating publuic route
resource "aws_route" "public-route" {
  route_table_id = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.demo-igw.id
}
#associating route table with subnet
resource "aws_route_table_association" "public-rt-assoc" {
  subnet_id      = aws_subnet.demo-subnet-public.id
  route_table_id = aws_route_table.public-rt.id
}