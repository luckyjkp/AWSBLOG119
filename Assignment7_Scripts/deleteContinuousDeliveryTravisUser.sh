#!/bin/bash

echo "Deleting User Policies..."
aws iam delete-user-policy --user-name Travis --policy-name Travis-Code-Deploy
aws iam delete-user-policy --user-name Travis --policy-name Travis-Upload-To-S3
echo "Deleting Travis User..."
aws iam delete-user --user-name Travis
echo "Deleted Travis User Successfully!!!"
