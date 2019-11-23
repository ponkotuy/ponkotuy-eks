terraform {
  required_version = "0.12.16"
  backend "s3" {
    bucket = "ponkotuy-eks"
    region = "ap-northeast-1"
    key = "terraform/default.tfstate"
  }
}

provider "aws" {
  version = "2.39.0"
  region = "ap-northeast-1"
}
