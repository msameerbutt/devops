# Docker for DevOps
This is a Swiss Army knife docker environment for DevOps related task.

## Tools
- Terraform
- Terraform Security
- AWS-CLI
- AWS SAM
- CFN-NAG
- Git
- Pre-Commit
- Go


### The environment
Execute the following command from the root directory of this repo

1. Copy `.env.example` and crate your `.env` file
1. `docker-compose build` to build docker image
1. Copy `alias.sh` file in your `~zrshc` file or your `bashrc` file
1. Run `docker_run` it will execute docker container and let you in

### Pre-Commit
- `pre-commit install` to install pre-commit dependencies defined in .pre-commit.yaml file.
- `pre-commit run --all-files` to run all pre-commit hooks at once.

### Golang
1. [How to write code in Golang](https://go.dev/doc/code)
