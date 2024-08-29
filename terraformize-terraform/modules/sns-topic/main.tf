provider "aws" {
  profile = "game-playground"
  region = "us-east-2"
}

resource "aws_sns_topic" "sns_approval" {
  name = "sns_approval"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sns_approval.arn
  protocol  = "email"
  endpoint  = "patricia@snsoft.my"
}

output "sns_approval_arn" {
  value = aws_sns_topic.sns_approval.arn
}