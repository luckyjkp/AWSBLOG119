#!/bin/bash


AMI="ami-5ac2cd4d"
INSTANCE_TYPE="t2.micro"
SECURITY_ID="sg-8c8603f1"
KEYPAIR_NAME="Team-9-csye6225"
EC2_ROLE="CodeDeployEC2ServiceRole"
PROFILE_INSTANCE="s3-access"

echo "Creating a keypair to access the instance. The private key would be stored as $KEYPAIR_NAME.pem"
aws ec2 create-key-pair --key-name $KEYPAIR_NAME --query 'KeyMaterial' --output text > $KEYPAIR_NAME.pem

echo "Attaching IAM Role to Instance Profile..."
aws iam create-instance-profile --instance-profile-name $PROFILE_INSTANCE
aws iam add-role-to-instance-profile --instance-profile-name $PROFILE_INSTANCE --role-name $EC2_ROLE
sleep 30

echo "Getting subnet ID for the us-east-1e subnet and configuring for auto-assign Public IP"
SUBNET=$(aws ec2 describe-subnets | grep -A2 "us-east-1e" | grep SubnetId | awk '{print$2}' | tr -cd '[:alnum:]\n-')
aws ec2 modify-subnet-attribute --subnet-id $SUBNET --map-public-ip-on-launch

echo "Launching an instance with all the required options."
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI --iam-instance-profile Name="s3-access" --count 1 --instance-type $INSTANCE_TYPE --key-name $KEYPAIR_NAME --security-group-ids $SECURITY_ID --subnet-id $SUBNET --region us-east-1 | grep InstanceId | awk '{print$2}' | tr -cd '[:alnum:]\n-')

echo "Checking if instance has reached running status.."

status=1
while [ $status == 1 ]; do
    INSTANCE_STATUS=$(aws ec2 describe-instance-status --instance-id $INSTANCE_ID  | grep -A3 "InstanceState" | grep "Name" | awk '{print$2}' | tr -cd '[:alnum:]\n')
    if [ "$INSTANCE_STATUS" == "running" ]; then
        status=0
        echo "Instance is ready!"
    else
        echo "Instance still not in running state. waiting for 30 seconds and then checking again."
        sleep 30
    fi
done

echo "Tagging the instance"
aws ec2 create-tags --resources $INSTANCE_ID --tags 'Key="[Team]",Value=9'

