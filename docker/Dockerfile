# Pullinsg latest image
FROM alpine:3.13

ENV TERRAFORM_VERSION=0.14.8

RUN apk --no-cache add git bash unzip wget && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin

RUN mkdir -p /app
WORKDIR /app

# Entry-point
ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint