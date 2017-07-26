#!/bin/bash

TABLE_NAME="csy571"

echo "Check if Dynamo table exists..."
CHECK=$(aws dynamodb list-tables | grep $TABLE_NAME)

if [ $? == 0 ]; then
    echo "Dynamo table already exists!!!"
    exit
else

    echo "Creating Dynamo Table.."
    aws dynamodb create-table --table-name $TABLE_NAME --attribute-definitions AttributeName=ID,AttributeType=N --key-schema AttributeName=ID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
fi


