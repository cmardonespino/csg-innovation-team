resource "aws_ecr_repository" "ecr" {
  name                 = var.service_name
}


resource "aws_ecr_repository_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
          "Sid": "AllowPull",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${aws_iam_role.ecs_role.arn}"
          },
          "Action": [
            "ecr:BatchCheckLayerAvailability",
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer"
          ]
        }
    ]
}
EOF

  depends_on = [aws_iam_role.ecs_role]
}