provider "aws" {
  region                  = "${var.aws_region}"
  version                 = "~> 2.1"
  shared_credentials_file = "/Users/rubelw/.aws/credentials"
  profile                 = "default"
}
