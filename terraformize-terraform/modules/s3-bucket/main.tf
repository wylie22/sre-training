provider "aws" {
  region  = var.AWS_REGION
  #profile = var.AWS_PROFILE  
}

resource "aws_s3_bucket" "bucketname" {
  bucket = var.TFSTATE_S3_NAME  # Ensure this bucket name is unique globally
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucketname.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucketname.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "bucket_arn" {
  value = aws_s3_bucket.bucketname.arn
}
