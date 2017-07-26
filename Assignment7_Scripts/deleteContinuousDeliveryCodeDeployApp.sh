#!/bin/bash

APPLICATION_NAME="BlogFolio"

echo "Deleting Code deploy Application...."
aws deploy delete-application --application-name $APPLICATION_NAME

echo "Application deleted Successfully!!!"
