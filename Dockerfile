# Pullinsg tfsec latest image
FROM aquasec/tfsec-alpine AS fsec
# Pulling golang latest image
FROM golang:1.21.3-alpine3.18 AS golang
# Pulling python image
FROM python:3.9.18-alpine3.18

ARG KUBE_VERSION
ARG HELM_VERSION
ARG TERRAFORM_VERSION
ARG TARGETOS
ARG TARGETARCH
ARG YQ_VERSION

# Environment Variables
ENV WORKING_DIR /app
ENV GOROOT /usr/local/go

# Creating Working Directory
RUN mkdir -p "${WORKING_DIR}" 

# Installing tfsec for Terraform security
COPY --from=fsec /usr/bin/tfsec /usr/local/bin/tfsec

###### INSTALL & CONFIGURE GO
COPY --from=golang /usr/local/go/ /usr/local/go/
# Creating Go Project Directory
RUN mkdir -p "${WORKING_DIR}" "${WORKING_DIR}/bin" && chmod -R 777 "${WORKING_DIR}"

RUN apk -U upgrade \
    && apk add --no-cache bash build-base ca-certificates curl gettext git jq openssh gcc python3 python3-dev musl-dev libffi-dev ruby-dev py3-pip unzip \
    && pip3 install --no-cache-dir requests pytest pytest-env boto3 pyyaml pipreqs pytz pre-commit\
    && rm -rf /var/cache/apk/*

RUN cd /tmp \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -O /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz -O - | tar -xzO ${TARGETOS}-${TARGETARCH}/helm > /usr/local/bin/helm \
    && wget -q https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_${TARGETOS}_${TARGETARCH} -O /usr/local/bin/yq \
    && wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${TARGETOS}_${TARGETARCH}.zip \
    && unzip -p terraform_${TERRAFORM_VERSION}_${TARGETOS}_${TARGETARCH}.zip >  /usr/local/bin/terraform \
    && rm -rf terraform_${TERRAFORM_VERSION}_${TARGETOS}_${TARGETARCH}.zip \
    && chmod +x /usr/local/bin/helm /usr/local/bin/kubectl /usr/local/bin/yq /usr/local/bin/terraform \
    && mkdir /config \
    && chmod g+rwx /config /root \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
    && kubectl version --client \
    && helm version \    
    && tfsec --version \ 
    && terraform --version \ 
    && rm -rf /var/cache/apk/*

RUN helm plugin install https://github.com/chartmuseum/helm-push
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install docker-compose-templer
RUN pip3 install --upgrade awscli aws-sam-cli cfn-lint
RUN gem install cfn-nag   

# Setting PathS
ENV PATH="${GOROOT}/bin:${PATH}"
ENV PATH="${WORKING_DIR}/bin:${PATH}"
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR $WORKING_DIR

# Entry-point
ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint