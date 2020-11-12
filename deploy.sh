#! /bin/bash

ACCOUNT_ID="471625376696"
DEPLOYMENT_NAME="activities"
API_SERVICE_NAME="api"
REGION="us-east-1"
VPC_ID="vpc-cbef20b6"
VPC_SUBNETS="\"subnet-b7229c96,subnet-37f3b07a\""
DOCKER_TAG="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${DEPLOYMENT_NAME}/${API_SERVICE_NAME}:latest"

## STEP 0 (if necessary) - Create ERC for API service base docker image

# To support pulling base Docker image from ECR because of Docker public image throttling
# https://www.docker.com/increase-rate-limit
# https://www.docker.com/blog/how-to-use-your-own-registry/
# aws ecr create-repository --repository-name ubuntu
# UBUNTU_LATEST_TAG="d70eaf7277ea" # Get with above command
# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 471625376696.dkr.ecr.us-east-1.amazonaws.com
# docker tag $UBUNTU_LATEST_TAG $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/ubuntu:latest
# docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/ubuntu:latest

## STEP 1 - Create ERC push first Image

# # Create ERC
# aws ecr create-repository --repository-name "${DEPLOYMENT_NAME}/${API_SERVICE_NAME}"

# # Push first Image to ERC
# docker build . -t $DOCKER_TAG
# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
# docker push $DOCKER_TAG
 
## STEP 2 - Create stack

# Create api infastructure with Cloud Formation
aws cloudformation update-stack \
    --stack-name $DEPLOYMENT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-body file://cloud-formation.yaml \
    --parameters ParameterKey=Container,ParameterValue=$DOCKER_TAG ParameterKey=VpcId,ParameterValue=$VPC_ID ParameterKey=SubnetId,ParameterValue=$VPC_SUBNETS

# aws cloudformation describe-stacks --stack-name $DEPLOYMENT_NAME

## STEP 3 - Grant ERC authorizatiopn

# # Note ARM created by CloudFormation is hardcoded in ecr-policy.json
# aws ecr set-repository-policy \
#     --repository-name "${DEPLOYMENT_NAME}/${API_SERVICE_NAME}" \
#     --policy-text file://ecr-policy.json 




