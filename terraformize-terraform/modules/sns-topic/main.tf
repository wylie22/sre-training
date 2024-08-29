provider "aws" {
  profile = "playground"
  region = "ap-southeast-1"
}

resource "aws_sns_topic" "sns_approval" {
  name = "sns_approval"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sns_approval.arn
  protocol  = "email"
  endpoint  = "wylieyap@snsoft.my"
}

output "sns_approval_arn" {
  value = aws_sns_topic.sns_approval.arn
}