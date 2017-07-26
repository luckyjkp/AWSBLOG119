#!/bin/bash

BUCKET_NAME="code-deploy.neu-csye6225-spring2017-team-9.info"

echo "Checking S3 bucket exists..."
S3_CHECK=$(aws s3 ls | grep $BUCKET_NAME)

if [ $? != 0 ]; then
    echo "Creating new bucket"
    aws s3api create-bucket --bucket $BUCKET_NAME --region us-east-1
    echo "enabling versioning"
    aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled
    echo "tagging bucket"
    aws s3api put-bucket-tagging --bucket $BUCKET_NAME --tagging 'TagSet=[{Key=Team,Value=9}]'
    echo "Read permission"
    aws s3api put-bucket-acl --bucket $BUCKET_NAME --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers
else
  echo "Bucket exists"
fi

