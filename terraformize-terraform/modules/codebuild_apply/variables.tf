# modules/codebuild_apply/variables.tf
variable "CODEBUILD_ROLE_ARN" {
  description = "The ARN of the role to use for CodeBuild"
  type        = string
}

variable "SOURCE_REPOSITORY_ID" {
  description = "Github source repo"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}