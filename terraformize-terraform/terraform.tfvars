##### AWS profile values #####
#AWS_PROFILE               = "playground"
AWS_REGION                = "ap-southeast-1"

##### Pipeline Values #####
project_name              = "wylie-project"
ARTIFACT_STORE_S3         = "wylie-codepipeline-bucket"   #s3 bucket for codepipeline artifacts storage (globally unique name)

##### Pipeline Triggers #####
SOURCE_BRANCH_NAME        = "main"
SOURCE_FILE_PATH          = "project-terraform-infra/**"   #can ignore this, unless u wanna specify file path for trigger

##### Git repo Settings #####
SOURCE_CONNECTION_ARN     = "arn:aws:codestar-connections:ap-southeast-1:905418182346:connection/6b3d4d68-4c6a-469e-b2c2-c4ee8769b3e4"   ##paste the codestar arn here
SOURCE_REPOSITORY_ID      = "wylie22/sre-training"   ##your github repo path

##### Codebuild job names (needs to be unique) #####
BUILD_PROJECT_NAME        = "wylie-tf-plan-codebuild"
APPLY_PROJECT_NAME        = "wylie-tf-apply-codebuild"

##### SNS Topic #####
SNS_TOPIC_EMAIL           = "wylieyap@snsoft.my"
