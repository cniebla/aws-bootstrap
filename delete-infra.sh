#!/bin/bash

STACK_NAME=awsbootstrap
REGION=us-east-2
CLI_PROFILE=default

# Delete the CloudFormation stack
echo -e "\n\n=========== Deleting stack ==========="
aws cloudformation delete-stack \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME
