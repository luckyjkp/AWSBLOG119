#!/bin/bash

EC2_ROLE="CodeDeployEC2ServiceRole"
SERVICE_ROLE="CodeDeployServiceRole"

echo "Creating Roles..."

aws iam create-role --role-name $EC2_ROLE --assume-role-policy-document file://ec2-role-trust-policy.json
aws iam attach-role-policy --policy-arn arn:aws:iam::638274294879:policy/CodeDeploy-EC2-S3 --role-name CodeDeployEC2ServiceRole
echo "Role CodeDeployEC2ServiceRole created successfully!!!"

aws iam create-role --role-name $SERVICE_ROLE --assume-role-policy-document file://CodeDeployTrust.json
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole --role-name CodeDeployServiceRole
echo "Role CodeDeployServiceRole created successfully!!!"
