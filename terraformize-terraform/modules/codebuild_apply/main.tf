##############################################################
################## TERRAFORM APPLY CODEBUILD #################
##############################################################
resource "aws_codebuild_project" "tf_apply_codebuild" {
  name        = "wylie-terraform-apply-codebuild"
  description = "Codebuild to TF Apply"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  service_role = var.CODEBUILD_ROLE_ARN

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.SOURCE_REPOSITORY_ID}"
    git_clone_depth = 1
    buildspec       = <<-BUILD_SPEC
version: 0.2

env:
  variables:
    TF_LOG: INFO

phases:
  install:
    runtime-versions:
      python: 3.x
    commands:
      - aws sts get-caller-identity
      - curl -LO https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_amd64.zip
      - unzip terraform_1.7.1_linux_amd64.zip
      - mv terraform /usr/local/bin/
      - rm terraform_1.7.1_linux_amd64.zip

  pre_build:
    commands:
      - echo "------------ Done setting up environment...------------"

  build:
    commands:
      - echo "------------ Initializing Terraform... ------------"
      - ls -la
      - cd project-terraform-infra && ls -la
      - terraform init
      - echo "------------ Applying Terraform... ------------"
      - terraform apply --auto-approve

  post_build:
    commands:
      - echo "------------ Terraform Apply completed ------------"
BUILD_SPEC
  }

  cache {
    type = "NO_CACHE"
  }

  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = "/aws/codebuild/${var.project_name}"
      stream_name = "build-log"
    }

    s3_logs {
      status              = "DISABLED"
      encryption_disabled = false
    }
  }

  build_timeout   = 60
  queued_timeout  = 480
  project_visibility = "PRIVATE"
}

output "codebuild_apply_name" {
  value = aws_codebuild_project.tf_apply_codebuild.name
}