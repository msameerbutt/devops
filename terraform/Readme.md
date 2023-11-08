# Terraform
A Terraform infrastructure based on AWS as provider, There few modules for varioius common scenaros

## Dependencies
- Terraform
- [TFSEC](https://aquasecurity.github.io/tfsec/v1.16.3/)

## Available Stack and their order
### 1. STACK = shared
Shared stack include the followings:

- IAM Roles and Policies
- Billing Alarms


Add following into your .env files or set the following environment variables

```
export ENVIRONMENT=dev
export TECHNICAL_OWNER=msameerbutt@gmail.com
export SERVICE=base
export AWS_DEFAULT_REGION=ap-southeast-2
export TF_VAR_environment=${ENVIRONMENT}
export TF_VAR_technical_owner=${TECHNICAL_OWNER}
export TF_VAR_service=${SERVICE}
export TF_VAR_region=${AWS_DEFAULT_REGION}
export TF_VAR_tf_state_bucket_name="sam-devops-scripts-files"
export TF_VAR_tf_state_bucket_key="${ENVIRONMENT}/${SERVICE}"
export STACK_NAME=base

cd /app/terraform/stacks/${STACK_NAME}/infra

terraform init \
-backend-config="key=${TF_VAR_tf_state_bucket_key}/${STACK_NAME}-infra.tfstate" \
-backend-config="region=${AWS_DEFAULT_REGION}" \
-backend-config="bucket=${TF_VAR_tf_state_bucket_name}"

terraform validate

terraform plan \
-var-file=../../../common/config/global.tfvars \
-var-file=../config/${ENVIRONMENT}.tfvars \
-var service=${SERVICE} \
-out=tf.plan

terraform apply tf.plan

terraform plan \
-destroy \
-var-file=../config/${ENVIRONMENT}.tfvars \
-var-file=../../../common/config/global.tfvars \
-var service=${SERVICE} \
-out=tf.plan

terraform apply tf.plan
```


## Resources
- [Running Terratest in a Docker Container](https://austincloud.guru/2021/06/24/running-terratest-in-a-docker-container/)
- [TFSEC](https://aquasecurity.github.io/tfsec/v1.16.3/)
- [docker-terratest](https://github.com/AustinCloudGuru/docker-terratest)
- [Using CloudFoundation to Build, Manage, and Deploy CloudFormation Templates](https://start.jcolemorrison.com/cloudfoundation-build-manage-and-deploy-cloudformation-templates/)
