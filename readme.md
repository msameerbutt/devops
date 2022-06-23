# Docker for DevOps
Swiss Army knife Docker Environment for DevOps task.

## Tools
- Terraform
- Terraform Security (TFSec)
- AWS-CLI
- AWS SAM
- CFN-NAG
- Git
- Pre-Commit
- Go

### Build Your Environment
Execute the following command from the root directory of this repo
1. Copy `.env.example` and crate your `.env` file
1. `docker-compose build` to build docker image
1. Copy `alias.sh` file in your `~zrshc` file or your `bashrc` file
1. Run `docker_up` it will execute docker container and let you in

### Pre-Commit Installation
- `pre-commit install` to install pre-commit dependencies defined in .pre-commit.yaml file.
- `pre-commit run --all-files` to run all pre-commit hooks at once.
