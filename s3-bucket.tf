resource "aws_s3_bucket" "mybucket" {
  bucket = "s3-bucket-loadbalancer-logs"

  tags = {
    Name        = "s3-bucket-loadbalancer-logs"
    Environment = "dev"
  }

}

resource "aws_s3_bucket_policy" "allow_elb_access_logs" {
  bucket = aws_s3_bucket.mybucket.id
  policy = data.aws_iam_policy_document.allow_access_logs.json
}

# Refer https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html for allowing access logs to loadbalancer
# Policy generator https://awspolicygen.s3.amazonaws.com/policygen.html

data "aws_iam_policy_document" "allow_access_logs" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::718504428378:root"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/${var.prefix}/AWSLogs/${data.aws_caller_identity.present-user.account_id}/*"
    ]
  }
}