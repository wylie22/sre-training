
#### Define the AWS IAM Role Policies #####
#### For CodeBuild purpose ####
variable "policy_arns" {
  type    = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser",
    "arn:aws:iam::905418182346:policy/EKS-FullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess"
  ]
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}
