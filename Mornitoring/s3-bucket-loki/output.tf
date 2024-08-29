output "bucket_names" {
  description = "S3 Bucket Name"
  value       = var.bucket_name 
}



output "Access_Policy" {
  description = "S3 Access Policy "
  value       = aws_iam_policy.loki.name
}