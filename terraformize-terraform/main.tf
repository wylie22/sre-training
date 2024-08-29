terraform {

  backend "s3" {
    profile = "<SSO Profile>"
    bucket  = "<bucket name>"
    region  = "<region>"
    key     = "state/terraform.tfstate"  ###path in the s3 bucket
  }
}


########### CREATE IAM ROLE MODULE ###########
module "iam_role" {
  source = "./modules/iam-role"
  project_name = var.project_name
}

output "codebuild_role_arn" {
  value = module.iam_role.codebuild_role_arn
}

########### CREATE CODEBUILD MODULES ###########
module "codebuild_plan" {
  source = "./modules/codebuild_plan"
  CODEBUILD_ROLE_ARN     = module.iam_role.codebuild_role_arn
  SOURCE_REPOSITORY_ID   = var.SOURCE_REPOSITORY_ID
  project_name           = var.project_name
}

module "codebuild_apply" {
  source = "./modules/codebuild_apply"
  CODEBUILD_ROLE_ARN     = module.iam_role.codebuild_role_arn
  SOURCE_REPOSITORY_ID   = var.SOURCE_REPOSITORY_ID
  project_name           = var.project_name
}

########### CREATE S3 BUCKET (for artifacts) ###########
resource "aws_s3_bucket" "artifacts" {
  bucket        = var.ARTIFACT_STORE_S3
  acl           = "private"
  force_destroy = "true"
}

provider "aws" {
  region  = var.AWS_REGION
  profile = var.AWS_PROFILE
}

########### CREATE SNS TOPIC ###########
resource "aws_sns_topic" "sns_approval" {
  name = "sns_approval"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sns_approval.arn
  protocol  = "email"
  endpoint  = var.SNS_TOPIC_EMAIL
}

output "sns_topic_arn" {
  value = aws_sns_topic.sns_approval.arn
}

########### CREATE CODEPIPELINE ###########
resource "aws_codepipeline" "example" {
  name            = var.project_name
  role_arn        = module.iam_role.codepipeline_role_arn
  execution_mode  = "QUEUED"
  pipeline_type   = "V2"

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifacts.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      namespace        = "SourceVariables"

      configuration = {
        BranchName            = var.SOURCE_BRANCH_NAME
        ConnectionArn         = var.SOURCE_CONNECTION_ARN
        DetectChanges         = "false"
        FullRepositoryId      = var.SOURCE_REPOSITORY_ID
        OutputArtifactFormat  = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Terraform-Plan"

    action {
      name             = "terraform-plan-codebuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      namespace        = "BuildVariables"

      configuration = {
        ProjectName = module.codebuild_plan.codebuild_plan_name
      }
    }
  }

  stage {
    name = "Email_Approval"

    action {
      name      = "approve-tf-plan"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 1

      configuration = {
        NotificationArn = aws_sns_topic.sns_approval.arn
      }
    }
  }

  stage {
    name = "Terraform-Apply"

    action {
      name             = "terraform-apply2-codebuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = []
      run_order        = 1

      configuration = {
        ProjectName = module.codebuild_apply.codebuild_apply_name
      }
    }
  }

  trigger {
    provider_type = "CodeStarSourceConnection"

    git_configuration {
      source_action_name = "Source"

      push {
        branches {
          includes = [var.SOURCE_BRANCH_NAME]
        }
#       file_paths {
#          includes = [var.SOURCE_FILE_PATH]
#        }
      }
    }
  }
}
