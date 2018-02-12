#!/bin/bash
# Information steps:
# 1) chmod u+x push-and-log.sh
# 2) ./push-and-log.sh
# cf api https://api.eu-gb.bluemix.net UK
# cf api https://api.ng.bluemix.net US

echo "*****************************************************"
echo "--> Ensure to deploy into the right bluemix region"
echo "-> Start"

user="[YOUR IBM Cloud ID]"
bluemix_api="https://api.[YOUR_REGION].bluemix.net"
organization_name="[YOUR_ORGANIZATION]"
space_name="[YOUR_SPACE]"
application_name="[YOUR_APPLICATION_NAME]"

echo "User: '$user' API: '$bluemix_api'"
echo "Organization: '$organization_name'"
echo "Space: '$space_name'"

echo "Insert your password:"
# How to input a password in bash shell
# http://stackoverflow.com/questions/3980668/how-to-get-a-password-from-a-shell-script-without-echoing
read -s password

bx login -a $bluemix_api -u $user -p $password -o $organization_name -s $space_name

echo "******************** START *********************************"
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
bx cf create-service conversation lite library-conversation

echo "Create AppId"
bx catalog service appid
bx cf create-service appid graduated-tier library-appid

echo "Create text-to-speech"
bx catalog service text-to-speech
bx cf create-service text-to-speech lite library-text-to-speech

echo "******************** DONE *********************************"
