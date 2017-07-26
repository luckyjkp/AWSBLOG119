#!/bin/bash

BUCKET_NAME="s3.neu-csye6225-spring2017-team-9.info"
echo "Creating Policies..."

echo "Policy for the Server (EC2)"
aws iam create-policy --policy-name CodeDeploy-EC2-S3 --policy-document file://policy.json
echo "Policy for the Server (EC2) successfully created!!"

echo "Policy for TravisCI to Upload to AWS S3"
aws iam create-policy --policy-name Travis-Upload-To-S3 --policy-document file://Travis-Upload-To-S3.json
echo "Policy for TravisCI to Upload to AWS S3 successfully created!!"

echo "Policy for TravisCI to Call CodeDeploy"
aws iam create-policy --policy-name Travis-Code-Deploy --policy-document file://Travis-Code-Deploy.json
echo "Policy for TravisCI to Call CodeDeploy successfully created!!"

