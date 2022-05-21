# Pullinsg latest image
# May be we should use this docker image
# https://github.com/zenika-open-source/terraform-aws-cli
FROM python:3.9-alpine3.12
ENV TERRAFORM_VERSION=0.15.3

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --update git curl bash unzip jq wget py3-virtualenv

RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir requests pytest pytest-env boto3 pyyaml pipreqs pytz awscli PyMySQL \
    && cd /tmp \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /app
WORKDIR /app

# Entry-point
ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint