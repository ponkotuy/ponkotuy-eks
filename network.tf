data "aws_vpc" "vpc" {
  id = "vpc-fbb5a099"
}

data "aws_subnet" "az-a" {
  id = "subnet-5c704628"
}

data "aws_subnet" "az-c" {
  id = "subnet-fcb2e4ba"
}

data "aws_subnet" "az-d" {
  id = "subnet-0bfb8923"
}
