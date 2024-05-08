data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "bucket_code" {
  bucket = var.bucket_code
}

resource "aws_s3_bucket" "bucket_lb_logs" {
  bucket = var.bucket_logs
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.bucket_lb_logs.id
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_code.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.iam_arn}"
      },
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.bucket_code.arn}",
        "${aws_s3_bucket.bucket_code.arn}/*"
      ]
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "main" {
  policy_id = "s3_bucket_lb_logs"

  statement {
    actions = [
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.bucket_lb_logs.arn}/*",
    ]

    principals {
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
      type        = "AWS"
    }
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.bucket_lb_logs.arn}/*"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }


  statement {
    actions = [
      "s3:GetBucketAcl"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.bucket_lb_logs.arn}"]
    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}