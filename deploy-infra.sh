#!/bin/bash

# Variables
STACK_NAME=awsbootstrap
REGION=us-east-2
CLI_PROFILE=default
EC2_INSTANCE_TYPE=t2.micro

# Semi-dynamic variables
AWS_ACCOUNT_ID=`aws sts get-caller-identity --profile $CLI_PROFILE \
--query "Account" --output text`
CODEPIPELINE_BUCKET="$STACK_NAME-$REGION-codepipeline-$AWS_ACCOUNT_ID"

# Dynamic variables
GH_ACCESS_TOKEN=$(cat ~/.github/aws-bootstrap-access-token)
GH_OWNER=$(cat ~/.github/aws-bootstrap-owner)
GH_REPO=$(cat ~/.github/aws-bootstrap-repo)
GH_BRANCH=main

# Deploys S3 Bucket
echo -e "\n\n=========== Deploying setup-s3.yaml ==========="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME-setup \
  --template-file setup-s3.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    CodePipelineBucket=$CODEPIPELINE_BUCKET

# Deploy the CloudFormation template
echo -e "\n\n=========== Deploying main.yaml ==========="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file main.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    EC2InstanceType=$EC2_INSTANCE_TYPE \
    GitHubOwner=$GH_OWNER \
    GitHubRepo=$GH_REPO \
    GitHubBranch=$GH_BRANCH \
    GitHubPersonalAccessToken=$GH_ACCESS_TOKEN \
    CodePipelineBucket=$CODEPIPELINE_BUCKET

# If the deploy succeeded, show the DNS name of the endpoints
if [ $? -eq 0 ]; then
  aws cloudformation list-exports \
    --profile default \
    --query "Exports[?ends_with(Name,'Endpoint')].Value"
fi