#!/bin/bash

echo "Deleting IAM policies..."

echo "Delete Policy for the Server (EC2)"
aws iam delete-policy --policy-arn arn:aws:iam::638274294879:policy/CodeDeploy-EC2-S3

echo "Delete Policy for TravisCI to Upload to AWS S3"
aws iam delete-policy --policy-arn arn:aws:iam::638274294879:policy/Travis-Upload-To-S3

echo "Delete Policy for TravisCI to Call CodeDeploy"
aws iam delete-policy --policy-arn arn:aws:iam::638274294879:policy/Travis-Code-Deploy

echo "Successfully deleted IAM policies..."
