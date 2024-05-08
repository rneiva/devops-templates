data "aws_iam_policy" "ecsTaskExecutionRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecsExecutionRolePolicy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_user" "bucket-user" {
  name          = var.iam_user
  path          = "/system/"
  force_destroy = true

}

resource "aws_iam_access_key" "user_bucket_key" {
  user = aws_iam_user.bucket-user.name
}

resource "aws_iam_user_policy" "main" {
  name = var.iam_ecr_policy
  user = aws_iam_user.bucket-user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "iam:*",
                "ecs:*",
                "logs:*",
                "ses:*",
                "sns:*",
                "cognito-idp:*"

            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = var.ecs_task_execution_role
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecsExecutionRolePolicy.json
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = data.aws_iam_policy.ecsTaskExecutionRolePolicy.arn
}