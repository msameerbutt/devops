# Cloudformation Guide
Find below some commnads to execute cloudformation template

### Create Stack
```
aws cloudformation create-stack \
--stack-name "demoApp" \
--template-body "file://network.yml" \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=dev
```

### Create changeset
```
aws cloudformation  create-change-set \
--change-set-name "AMIUpdatedProd" \
--stack-name "demoApp" \
--template-body "file://network.yml" \
--parameters \
ParameterKey=EnvironmentName,ParameterValue=prod
```

### Execute changeset
```
aws cloudformation execute-change-set \
--change-set-name "AMIUpdatedProd" \
--stack-name "demoApp"
```

### Destroy Stack
```
aws cloudformation delete-stack --stack-name "demoApp"
```