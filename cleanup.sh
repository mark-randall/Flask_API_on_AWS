#! /bin/bash

ACCOUNT_ID="471625376696"
DEPLOYMENT_NAME="activities"
API_SERVICE_NAME="api"
REGION="us-east-1"

# Clean up bucket. CloudFormation can't delete if bucket contains files
aws s3 rm s3://$ACCOUNT_ID-$DEPLOYMENT_NAME-codepipelineartifacts --recursive

# Clean up ECR API repository
IMAGES_TO_DELETE=$( aws ecr list-images \
    --region $REGION --repository-name "${DEPLOYMENT_NAME}/${API_SERVICE_NAME}" \
    --query 'imageIds[*]' \
    --output json )
aws ecr batch-delete-image \
    --region $REGION \
    --repository-name "${DEPLOYMENT_NAME}/${API_SERVICE_NAME}" \
    --image-ids "$IMAGES_TO_DELETE" || true

# Delete stack
aws cloudformation delete-stack --stack-name $DEPLOYMENT_NAME