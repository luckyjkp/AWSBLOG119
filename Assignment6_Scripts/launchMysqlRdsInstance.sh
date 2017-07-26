#!/bin/bash

DB_INSTANCE="csye57"
DB_INSTANCE_CLASS="db.t2.micro"
DB_ENGINE="mysql"
USER_NAME="csye6225"
PASSWORD="csye6225"
DB_NAME="csye6225"
VPC="sg-8587b8f9"

echo "Check if RDS instance exists..."
CHECK=$(aws rds describe-db-instances | grep DBInstanceIdentifier | grep $DB_INSTANCE)

if [ $? == 0 ]; then
    echo "RDS already exists!!!"
    exit
else

    echo "Creating MySQL RDS Instance.."
    aws rds create-db-instance --db-instance-identifier $DB_INSTANCE --allocated-storage 5 --db-instance-class $DB_INSTANCE_CLASS --engine $DB_ENGINE --master-username $USER_NAME --master-user-password $PASSWORD --db-name  $DB_NAME --vpc-security-group-ids $VPC --no-publicly-accessible
fi


