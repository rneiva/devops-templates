output "bucket_region" {
  value = aws_s3_bucket.bucket_code.region

}

output "bucket_lb_logs" {
  value = aws_s3_bucket.bucket_lb_logs.bucket
}
