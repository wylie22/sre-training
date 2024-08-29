
# Set your cluster name
cluster_name="ColorGame-App-QAT"
region="ap-southeast-1"

EKS_ROLE=$(aws eks describe-cluster --region $region --name $cluster_name | jq -r '.cluster.roleArn')

# Get the node group names (assuming a single node group for simplicity)
node_group=$(aws eks list-nodegroups --region $region --cluster-name $cluster_name --query "nodegroups[0]" --output text )

# Get the IAM role associated with the node group
node_role_arn=$(aws eks describe-nodegroup --region $region --cluster-name $cluster_name --nodegroup-name $node_group --query "nodegroup.nodeRole" --output text)

# Extract just the role name from the ARN
node_role=$(echo $node_role_arn | awk -F'/' '{print $NF}')

terraform init
terraform apply -var region="$region" -var bucket_name="colorgame-app-qat-loki-s3"  -var cluster_name="$cluster_name" -var cluster_iam=$EKS_ROLE -var node_role=$node_role -var namespace="prometheus"


#terraform destroy -var region="$region" -var bucket_name="$cluster_name-loki-s3"  -var cluster_name="$cluster_name" -var cluster_iam=$EKS_ROLE -var node_role=$node_role -var namespace="prometheus"
