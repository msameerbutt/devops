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
export ENV_PROFILE=dev
export ENV_OWNER=sam
export ENV_NAME=base
export ENV_REGION=ap-southeast-2
export TF_VAR_env_profile=${ENV_PROFILE}
export TF_VAR_env_owner=${ENV_OWNER}
export TF_VAR_env_name=${ENV_NAME}
export TF_VAR_region=${ENV_REGION}
export TF_VAR_tf_state_bucket_name="sam-devops-scripts-files"
export TF_VAR_tf_state_bucket_key="${ENV_NAME}/${ENV_NAME}"
export STACK_NAME=shared

cd /app/terraform/stacks/${STACK_NAME}/infra

terraform init \
-backend-config="key=${TF_VAR_tf_state_bucket_key}/${STACK_NAME}-infra.tfstate" \
-backend-config="region=${ENV_REGION}" \
-backend-config="bucket=${TF_VAR_tf_state_bucket_name}"

terraform validate

terraform plan \
-var-file=../../../common/config/global.tfvars \
-var-file=../config/${ENV_PROFILE}.tfvars \
-var env_name=${ENV_NAME} \
-out=tf.plan

terraform apply tf.plan

terraform plan \
-destroy \
-var-file=../config/${ENV_PROFILE}.tfvars \
-var-file=../../../common/config/global.tfvars \
-var env_name=${ENV_NAME} \
-out=tf.plan

terraform apply tf.plan
```


## Resources
- [Running Terratest in a Docker Container](https://austincloud.guru/2021/06/24/running-terratest-in-a-docker-container/)
- [TFSEC](https://aquasecurity.github.io/tfsec/v1.16.3/)
- [docker-terratest](https://github.com/AustinCloudGuru/docker-terratest)
- [Using CloudFoundation to Build, Manage, and Deploy CloudFormation Templates](https://start.jcolemorrison.com/cloudfoundation-build-manage-and-deploy-cloudformation-templates/)
