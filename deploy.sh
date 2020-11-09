ACCOUNT_ID="471625376696"
CLUSTER_NAME="activities"
REGION="us-east-1"

DOCKER_TAG="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${CLUSTER_NAME}/api:latest"

# Create api infastructure with Cloud Formation
aws cloudformation update-stack \
    --stack-name $CLUSTER_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-body file://cloud-formation.yaml \
    --parameters ParameterKey=Container,ParameterValue=$DOCKER_TAG ParameterKey=VpcId,ParameterValue=vpc-cbef20b6 ParameterKey=SubnetId,ParameterValue=\"subnet-b7229c96,subnet-37f3b07a\"

# Build and push container image to ECR. Go to ECR and follow 'View push commands' instructions.
# 1. docker build . -t $DOCKER_TAG
# 2. login to ECR 
# 3. docker push $DOCKER_TAG

