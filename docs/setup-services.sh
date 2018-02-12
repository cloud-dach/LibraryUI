#!/bin/bash
# Information steps:
# 1) chmod u+x push-and-log.sh
# 2) ./push-and-log.sh
# cf api https://api.eu-gb.bluemix.net UK
# cf api https://api.ng.bluemix.net US

echo "*****************************************************"
echo "--> Ensure you are in the right IBM Cloud region"
echo "-> Start"

user="YOUR_USER_ID"
bluemix_api="https://api.[YOUR_REGION].bluemix.net"
organization_name="YOUR_ORG_NAME"
space_name="YOUR_SPACE_NAME"
account="YOUR_ACCOUNT_ID"
application_name="[YOUR_APPLICATION_NAME]"
resourcegroup="default"

echo "User: '$user' API: '$bluemix_api'"
echo "Organization: '$organization_name'"
echo "Space: '$space_name'"

echo "Insert your password:"
# How to input a password in bash shell
# http://stackoverflow.com/questions/3980668/how-to-get-a-password-from-a-shell-script-without-echoing
read -s password
bx login -a $bluemix_api -u $user -c $account -p $password -o $organization_name -s $space_name -g $resourcegroup

echo "******************** START *********************************"
echo "****** account information"
bluemix account list

echo "****** show existing spaces"
cf spaces
echo "****** show existing apps *********"
cf apps
echo "****** show existing services *********"
cf services
echo "****** show catalog services for IBM *********"
bx catalog service-marketplace | grep 'IBM'

echo "****** Create Services *********"
echo "Create Services"

echo "Create Conversation"
bx catalog service conversation
bx cf create-service conversation free library-conversation

echo "Create AppId"
bx catalog service appid
bx cf create-service appid graduated-tier library-appid

echo "Create text-to-speech"
bx catalog service text-to-speech
bx cf create-service text-to-speech lite library-text-to-speech

echo "******************** DONE *********************************"
