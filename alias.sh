#!/bin/sh

# Docker Clean up!
# Example: docker_clean
docker_clean(){
  docker rm $(docker ps -a -f status=exited -q)
  docker rmi $(docker images -q -f dangling=true)
  docker volume ls -f dangling = true
}

# Docker Exec
# Example docker_exec container_name/id bash
docker_exec() {
  if [ -z "$2" ]; then
    $2=bash
  fi
  docker exec -it $1 $2
}

# Docker Up
# Example docker_up "msameerbutt/learning/terraform:latest /bin/bash" "./" "/app"
docker_up() {
  [[ ! -z "$1" ]] && docker_cmd=$1 || docker_cmd="msameerbutt/learning/terraform:latest /bin/bash"
  [[ ! -z "$2" ]] && host_dir=$2 || host_dir=$(pwd)
  [[ ! -z "$3" ]] && container_dir=$3 || container_dir="/app"

  echo "Mounting '${host_dir}' into '${container_dir}'"
  docker container run \
  --rm \
  -it \
  -v ${host_id}:${container_dir} \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --network="bridge" \
  --workdir="${container_dir}" \
  ${docker_cmd}
}

docker_manager() {
  docker container run
  -p 9000:9000 \
  --rm \
  -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  portainer/portainer
}
