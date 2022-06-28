# Docker for DevOps
Swiss Army knife Environment to perform Infrastructure Automation task.

## Tools
- Python 3.9.13
- Go 1.17.10 linux/amd64
- Git 2.34.2
- Terraform v0.15.3
- Terraform Security (v1.21.2)
- AWS-CLI 1.25.2
- AWS SAM
- CFN-NAG 0.8.10
- Pre-Commit 2.19.0

### Build Your Environment
Execute the following command from the root directory of this repo
1. Copy `.env.example` and crate your `.env` file
1. `docker-compose build` to build docker image
1. Copy `alias.sh` file in your `~zrshc` file or your `~bashrc` file
1. Refresh your terminal session to load the latest scripts
1. Run `docker_up` it will execute docker container and let you in

### Pre-Commit Installation
Note: to run pre-commit from with in docker follow the additional first two steps
- `docker_up` to run the docker
- `export XDG_CACHE_HOME=/tmp` to change the cache directory from /.cache to tmp
- `pre-commit install` to install pre-commit dependencies defined in .pre-commit.yaml file.
- `pre-commit run --all-files` to run all pre-commit hooks at once.

### Execute Go Functions

### Execute Python Functions

### Execute Terraform

### Execute AWS CLI operations
