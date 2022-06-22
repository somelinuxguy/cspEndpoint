# What do:
# Make a lambda function, attach an IAM role to it
# Zip the code, and deploy it to the function
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  profile = "lazlo"
}

variable "lambda_function_name" {
  default = "cspendpoint"
}

data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${path.module}/../main.js"
  output_path = "${path.module}/lambda_function.zip"
}

# An IAM role and policy for the lambda
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
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create a log group for this lambda function
resource "aws_cloudwatch_log_group" "csp_endpoint" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
}

# Make a basic logging policy
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Attach the logging policy to the iam_for_lambda role
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

# the actual lambda function
resource "aws_lambda_function" "csp_endpoint_lambda" {
  filename      = "${data.archive_file.lambda_zip.output_path}"
  package_type = "Zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  handler = "main.handler"
  runtime = "nodejs14.x"

  environment {
    variables = {
      do_i_look_nice_today = "yes"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.csp_endpoint,
  ]
}