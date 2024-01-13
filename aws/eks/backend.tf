terraform {
  backend "s3" {
    bucket         = "tfstate"
    key            = "aws/eks"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}