output "sns_endpoint" {
  value = aws_sqs_queue.main.arn
}