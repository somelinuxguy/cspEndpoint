output "base_url" {
  description = "Base URL for the CSP Endpoint stage"
  value = aws_apigatewayv2_stage.lambda.invoke_url
}