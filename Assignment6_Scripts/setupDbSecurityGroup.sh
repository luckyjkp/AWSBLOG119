#!/bin/bash

GROUP_NAME="db"

echo "show default VPC"
VPC=$(aws ec2 describe-vpcs | grep -B10 "\"IsDefault\": true" | grep VpcId | awk '{print$2}' | tr -cd '[:alnum:]\n-')

GROUP_CHECK=$(aws ec2 describe-security-groups | grep -B1 $VPC | grep $GROUP_NAME | awk '{print$2}' | tr -cd '[:alnum:]\n-')

if [ $? == 0 ]; then
    echo "Group exists"
    echo "Deleting group"
    aws ec2 delete-security-group --group-name $GROUP_NAME
   
   
fi
    echo "New Security group!!"
    echo "creating db scurity groups"
    aws ec2 create-security-group --group-name $GROUP_NAME --description "DB security group" --vpc-id $VPC

    echo "Authorize web scurity group with port 80 and port 443"
    aws ec2 authorize-security-group-ingress --group-name $GROUP_NAME --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 3306, "ToPort": 3306, "UserIdGroupPairs": [{"GroupId": "sg-c98cb3b5"}]}]'



