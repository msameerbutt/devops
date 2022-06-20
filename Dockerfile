# Pullinsg tfsec latest image
FROM aquasec/tfsec AS fsec
# Pulling golang latest image
FROM golang:1.17-alpine3.15 AS golang
# Pulling python image
FROM python:3.9-alpine3.15

ENV TERRAFORM_VERSION=0.15.3

RUN apk update && \
 apk upgrade && \
 apk add --no-cache --update git curl bash unzip jq wget gcc py3-virtualenv ruby

# Installing AWS-CLI, Boto3, Python Libraries, Terraform, CFN-Nag
RUN pip3 install --upgrade pip \
 && pip3 install --no-cache-dir requests pytest pytest-env boto3 pyyaml pipreqs pytz awscli PyMySQL pre-commit \
 && cd /tmp \
 && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
 && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
 && gem install cfn-nag \
 && rm -rf /var/cache/apk/*

# Installing AWS SAM CLI
RUN apk -v --no-cache --update add \
     musl-dev \
     gcc \
     python3 \
     python3-dev
RUN python3 -m ensurepip --upgrade \
     && pip3 install --upgrade pip
RUN pip3 install --upgrade awscli aws-sam-cli
RUN apk del python3-dev gcc musl-dev


# Installing tfsec for Terraform security
COPY --from=fsec /usr/bin/tfsec /bin/tfsec
# Installing Golang for Terratets
COPY --from=golang /usr/local/go/ /usr/local/go/
# Setting Goroot path
ENV GOROOT /usr/local/go
ENV PATH="${GOROOT}/bin:${PATH}"
# Setting Project directory
ENV GOPATH /app
ENV PATH="${GOPATH}/bin:${PATH}"

RUN mkdir -p "$GOPATH" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH


ENV PATH="/usr/local/go/bin:${PATH}"

RUN mkdir -p /app
WORKDIR /app

# Entry-point
ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
