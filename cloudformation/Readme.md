# Cloudformation Guide
Find below some commnads to execute cloudformation template

### Create Stack
```
aws cloudformation create-stack \
--stack-name "demoApp" \
--template-body "file://network.yml" \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=dev

aws cloudformation create-stack \
--stack-name "Foundation" \
--template-body "file://foundation.yml" \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=dev

aws cloudformation create-stack \
--stack-name "demoApp" \
--template-body "file://ec2.yml" \
--capabilities CAPABILITY_NAMED_IAM

### Create changeset
```
aws cloudformation  create-change-set \
--change-set-name "AMIUpdatedProd" \
--stack-name "demoApp" \
--template-body "file://ec2.yml" \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=prod

aws cloudformation  create-change-set \
--change-set-name "OutputAdded" \
--stack-name "Foundation" \
--template-body "file://foundation.yml" \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=dev

aws cloudformation  create-change-set \
--change-set-name "NginxAdded" \
--stack-name "demoApp" \
--template-body "file://ec2.yml" \
--capabilities CAPABILITY_NAMED_IAM
```

### Execute changeset
```
aws cloudformation execute-change-set \
--change-set-name "AMIUpdatedProd" \
--stack-name "demoApp"

aws cloudformation execute-change-set \
--change-set-name "OutputAdded" \
--stack-name "Foundation"

aws cloudformation execute-change-set \
--change-set-name "NginxAdded" \
--stack-name "demoApp"
```

### Destroy Stack
```
aws cloudformation delete-stack --stack-name "demoApp"
```