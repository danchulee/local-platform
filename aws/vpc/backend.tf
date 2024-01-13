terraform {
  backend "s3" {
    bucket         = "tfstate"
    key            = "aws/vpc"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}