resource "aws_iam_policy" "access-s3-from-ec2-policy" {
  name = "access-s3-from-ec2-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${aws_s3_bucket.mybucket.id}"
      },
    ]
  })
}


resource "aws_iam_role" "access-s3" {
  name = "access-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          "Service" = "ec2.amazonaws.com"
        },
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3-access-from-ec2" {
  role       = aws_iam_role.access-s3.name
  policy_arn = aws_iam_policy.access-s3-from-ec2-policy.arn
}

resource "aws_iam_instance_profile" "access-s3-profile" {
  name = "access-s3-profile"
  role = aws_iam_role.access-s3.name
}