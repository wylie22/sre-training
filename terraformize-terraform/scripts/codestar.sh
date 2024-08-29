#!/bin/bash

# Variables
profile="playground"
region="ap-southeast-1"
provider_type="GitHub"
connection_name="wylie-github-connection"
output_file="codestar-arn.json"

# Create the connection
aws codestar-connections create-connection --profile $profile --region $region --provider-type $provider_type --connection-name $connection_name > "$output_file"

# Check if the command was successful
if [ $? -eq 0 ]; then
  echo -e "\033[0;32mConnection created successfully and output saved to $output_file.\033[0m"
else
  echo -e "\033[0;31mFailed to create connection. Please check the output file for more details.\033[0m"
fi

echo "--------- Go to the AWS Console to update the pending connection status ---------"
echo "Developer Tools -> Settings -> Connections -> Update pending connection"           
