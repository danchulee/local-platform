data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket            = "tfstate"
    key               = "aws/vpc"
    region            = "us-east-1"
    access_key        = "test"
    secret_key        = "test"
    endpoint          = "http://s3.localhost.localstack.cloud:4566"
    iam_endpoint      = "http://localhost:4566"
    sts_endpoint      = "http://localhost:4566"
    dynamodb_endpoint = "http://localhost:4566"
  }
}
