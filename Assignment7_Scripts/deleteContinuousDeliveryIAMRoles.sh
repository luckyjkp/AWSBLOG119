#!/bin/bash

EC2_ROLE="CodeDeployEC2ServiceRole"
SERVICE_ROLE="CodeDeployServiceRole"

echo "Deleting IAM Roles..."
aws iam detach-role-policy --role-name $EC2_ROLE --policy-arn arn:aws:iam::638274294879:policy/CodeDeploy-EC2-S3
aws iam delete-role --role-name $EC2_ROLE
echo "EC2 Role Deleted!!!"

aws iam detach-role-policy --role-name $SERVICE_ROLE --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole
aws iam delete-role --role-name $SERVICE_ROLE
echo "Service Role Deleted!!!"


