
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  s3_key     = "${var.s3_key}"
  s3_bucket = "${var.s3_bucket_name}"
  function_name = "lambda_function_name"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "${var.handler}"


  runtime = "${var.runtime}"

  environment {
    variables = {
      WEBHOOK_URL = "${var.webhookurl}"
      API_KEY = "${var.apikey}"
    }
  }
}

resource "aws_cloudwatch_event_rule" "every_friday" {
    name = "every-friday-at-9am"
    description = "Fires every friday at 9am"
    #schedule_expression = "cron(0 9 ? * FRI *)"
    schedule_expression = "rate(2 minutes)"
}

resource "aws_cloudwatch_event_target" "cashcat_every_friday" {
    rule = "${aws_cloudwatch_event_rule.every_friday.name}"
    target_id = "post_to_slack"
    arn = "${aws_lambda_function.test_lambda.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_cashcat" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.test_lambda.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.every_friday.arn}"
}