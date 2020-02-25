# Required variables


variable s3_key {
  default="xxxx"
}

variable s3_bucket_name {
  default = "xxxx"
}

variable webhookurl {
  default = "https://hooks.slack.com/services/xxxx/xxxx/xxxx"
}

variable apikey {
  default = "xxxx"
}


variable "handler" {
  description = "the function entrypoint"
  default     = "lambda_function.lambda_handler"
}

variable "runtime" {
  description = "the runtime for the lambda function"
  default     = "python3.7"
}

variable "aws_region" {
  description = "aws region for deployment"
  default     = "us-east-1"
}

