#!/bin/bash

STACK_NAME=awsbootstrap
REGION=us-east-2
CLI_PROFILE=default

EC2_INSTANCE_TYPE=t2.micro

# Deploy the CloudFormation template
echo -e "\n\n=========== Deleting stack ==========="
aws cloudformation delete-stack \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME