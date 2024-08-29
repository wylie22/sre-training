##### AWS profile values #####
AWS_PROFILE               = "<SSO Profile>"
AWS_REGION                = "<region>"

##### Pipeline Values #####
project_name              = "<pipeline project name>"
ARTIFACT_STORE_S3         = "<artifact name>"   #s3 bucket for codepipeline artifacts storage (globally unique name)

##### Pipeline Triggers #####
SOURCE_BRANCH_NAME        = "main"
#SOURCE_FILE_PATH          = "ec2/**"   #can ignore this, unless u wanna specify file path for trigger

##### Git repo Settings #####
SOURCE_CONNECTION_ARN     = "<codestar arn>"   ##paste the codestar arn here
SOURCE_REPOSITORY_ID      = "GIT REPO"   ##your github repo path

##### Codebuild job names (needs to be unique) #####
BUILD_PROJECT_NAME        = "tf-plan-codebuild"
APPLY_PROJECT_NAME        = "tf-apply-codebuild"

##### SNS Topic #####
SNS_TOPIC_EMAIL           = "wllam@snsoft.my"
