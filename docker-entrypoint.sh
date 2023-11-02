#!/bin/bash

set -e

# Welcome Message
echo "Default entrypoint Terraform $@"
terraform --version
kubectl version --client
helm version    
tfsec --version
yq --version
docker-compose-templer --version
cfn_nag --version
cfn-lint --version

# To proceed with command execution
exec $@