# Terraform
A php laravel project infrastructure based on AWS as provider


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
export STACK_NAME=iam

cd /app/stacks/${STACK_NAME}/infra

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