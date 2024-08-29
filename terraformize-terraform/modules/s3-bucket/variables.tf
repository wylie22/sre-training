variable "AWS_PROFILE" {
  description	= "AWS profile name"
  type		= string
  default	= "playground"
}

variable "AWS_REGION" {
  description	= "AWS region"
  type		= string
  default	= "ap-southeast-1"
}

variable "TFSTATE_S3_NAME" {
  description	= "Unique name for the s3 bucket for tfstate"
  type		= string
  default	= "wylie-tfstate-bucket"
}
