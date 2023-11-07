# AWS CloudFormation
This will provide to deploy/modify/remove AWS resources using AWS CloudFormation templates

### Build Your Environment
Go to main readme.md file and follow the steps in [Build Your Environment](../readme.md) and Execute `docker_up` command.
Following steps command must be executed within the container.

### Creat Stack
Execute the following command to create a stack.
```
export STACK_NAME="shared"
export TEMPLATE_BODY="file:///app/cloudformation/stacks/${STACK_NAME}/template.yml"

aws cloudformation create-stack \
--stack-name ${STACK_NAME} \
--template-body ${TEMPLATE_BODY} \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=${SERVICE} \
ParameterKey=EnvironmentProfile,ParameterValue=${ENVIRONMENT} \
ParameterKey=EnvironmentOwner,ParameterValue=${TECHNICAL_OWNER} \
ParameterKey=StackName,ParameterValue=${StackName} \
--capabilities CAPABILITY_AUTO_EXPAND

export STACK_NAME="network"
export TEMPLATE_BODY="file://app/cloudformation/stacks/${STACK_NAME}.yml"

aws cloudformation create-stack \
--stack-name ${STACK_NAME} \
--template-body ${TEMPLATE_BODY} \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=${ENVIRONMENT},
ParameterKey=EnvironmentProfile,ParameterValue=${ENVIRONMENT},
```
### Creat Stack with capabilities
Execute the following command to create a stack.
```
export STACK_NAME="ec2"
export TEMPLATE_BODY="file://app/cloudformation/stacks/${STACK_NAME}.yml"

aws cloudformation create-stack \
--stack-name ${STACK_NAME} \
--template-body ${TEMPLATE_BODY} \
--capabilities CAPABILITY_NAMED_IAM \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=${ENVIRONMENT},
ParameterKey=EnvironmentProfile,ParameterValue=${ENVIRONMENT},
```
### Create a ChangeSet Stack
Execute the following command to create & execute a stack ChangeSet.
```
export STACK_NAME="ec2"
export TEMPLATE_BODY="file://app/cloudformation/stacks/${STACK_NAME}.yml"

aws cloudformation  create-change-set \
--stack-name ${STACK_NAME} \
--change-set-name "${STACK_NAME}-change-set-1" \
--template-body ${TEMPLATE_BODY} \
--capabilities CAPABILITY_NAMED_IAM \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=${ENVIRONMENT},
ParameterKey=EnvironmentProfile,ParameterValue=${ENVIRONMENT}

aws cloudformation execute-change-set \
--stack-name ${STACK_NAME} \
--change-set-name "${STACK_NAME}-change-set-1"
```

### Destroy Stack
```
export STACK_NAME="ec2"
aws cloudformation delete-stack --stack-name "${STACK_NAME}"
```
