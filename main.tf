provider "aws" {
  region = "us-east-1"
}

/*resource "aws_iam_role" "lambda_execution_role" {
  
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  ]
}
*/
resource "aws_lambda_function" "lambda_function" {
  function_name = "mi-nueva-funcion"
  role          = "arn:aws:iam::489568735630:role/lambda_execution_role"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  filename      = "${path.module}/lambda_function.zip"

  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      foo = "bar"
    }
  }
}
