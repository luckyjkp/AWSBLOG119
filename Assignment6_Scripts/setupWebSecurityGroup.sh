#!/bin/bash

GROUP_NAME="web"

echo "show default VPC"
VPC=$(aws ec2 describe-vpcs | grep -B10 "\"IsDefault\": true" | grep VpcId | awk '{print$2}' | tr -cd '[:alnum:]\n-')
echo "VPC $VPC"

GROUP_CHECK=$(aws ec2 describe-security-groups | grep -B1 $VPC | grep $GROUP_NAME | awk '{print$2}' | tr -cd '[:alnum:]\n-')

if [ $? == 0 ]; then
    echo "Group exists"
    echo "Deleting group"
    aws ec2 delete-security-group --group-name $GROUP_NAME
    echo "Successfully Deleted group..."
   
fi
    echo "New Security group!!"
    echo "creating web scurity groups"
    aws ec2 create-security-group --group-name $GROUP_NAME --description "web security group" --vpc-id $VPC
    echo "Successfully created!!!"
    echo "Authorize web scurity group with port 80 and port 443"
    aws ec2 authorize-security-group-ingress --group-name $GROUP_NAME --protocol tcp --port 80 --cidr 0.0.0.0/0
    aws ec2 authorize-security-group-ingress --group-name $GROUP_NAME --protocol tcp --port 443 --cidr 0.0.0.0/0


