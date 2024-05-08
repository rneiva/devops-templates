output "iam_user" {
  value = aws_iam_user.bucket-user.name

}

output "iam_secret_key" {
  value = aws_iam_access_key.user_bucket_key.encrypted_secret
}

output "iam_arn" {
  value = aws_iam_user.bucket-user.arn
}

output "ecs_task_execution_role" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}