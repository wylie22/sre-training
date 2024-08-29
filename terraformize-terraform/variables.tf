variable "AWS_PROFILE" {
  description = "AWS profile name"
  type        = string
}

variable "AWS_REGION" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "ARTIFACT_STORE_S3" {
  description = "Location of the S3 artifact store"
  type        = string
}

variable "SOURCE_BRANCH_NAME" {
  description = "Source branch name"
  type        = string
}

variable "SOURCE_CONNECTION_ARN" {
  description = "ARN of the CodeStar connection"
  type        = string
}

variable "SOURCE_REPOSITORY_ID" {
  description = "ID of the source repository"
  type        = string
}

#variable "SOURCE_FILE_PATH" {
#  description = "path inside your tf code for pipeline trigger"
#  type        = string
#}

variable "BUILD_PROJECT_NAME" {
  description = "Name of the CodeBuild project for the build stage"
  type        = string
}

variable "APPLY_PROJECT_NAME" {
  description = "Name of the CodeBuild project for the apply stage"
  type        = string
}

variable "SNS_TOPIC_EMAIL" {
  description = "email of the approval person"
  type        = string
}

