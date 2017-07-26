#!/bin/bash

APPLICATION_NAME="Blogfolio"
DEPLOYMENT_GROUP="Blogfolio"
KEY="Team"
VALUE="9"
SERVICE_ROLE="arn:aws:iam::638274294879:role/CodeDeployServiceRole"


echo "Creating an application!!"
aws deploy create-application --application-name $APPLICATION_NAME

echo "Creating Deployement group!!"
aws deploy create-deployment-group --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP --ec2-tag-filters Key=$KEY,Value=$VALUE,Type=KEY_AND_VALUE --service-role-arn $SERVICE_ROLE

