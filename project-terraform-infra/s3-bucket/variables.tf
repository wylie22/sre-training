variable "AWS_PROFILE" {
  description	= "AWS profile name"
  type		= string
  default	= "<SSO Profile>"
}

variable "AWS_REGION" {
  description	= "AWS region"
  type		= string
  default	= "<region>"
}

variable "TFSTATE_S3_NAME" {
  description	= "Unique name for the s3 bucket for tfstate"
  type		= string
  default	= "<bucket name>"
}
