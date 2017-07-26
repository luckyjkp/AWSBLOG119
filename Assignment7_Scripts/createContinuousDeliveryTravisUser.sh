#!/bin/bash

echo "Creating Travis User"
aws iam create-user --user-name Travis

echo "Attaching policies to travis user.."

echo "1st policy--- Travis-Upload-To-S3"
aws iam put-user-policy --user-name Travis --policy-name Travis-Upload-To-S3 --policy-document file://Travis-Upload-To-S3.json

echo "2nd policy--- Travis-Code-Deploy"
aws iam put-user-policy --user-name Travis --policy-name Travis-Code-Deploy --policy-document file://Travis-Code-Deploy.json

echo "Policies are attached successfully!!!"


