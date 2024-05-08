#!/bin/bash

echo "\n Removing volumes that isn't using.."
docker volume rm $(docker volume ls -qf dangling=true)

export BEFORE_DATETIME=$(date --date='10 weeks ago' +"%Y-%m-%dT%H:%M:%S.%NZ");
export IMAGE_CTIME=$(docker inspect --format='{{.Created}}' --type=image ${IMAGE_ID});

docker images -q | while read IMAGE_ID; do          
    if [[ "${BEFORE_DATETIME}" > "${IMAGE_CTIME}" ]]; then
    echo "Removing ${IMAGE_ID}, ${BEFORE_DATETIME} is earlier then ${IMAGE_CTIME}";
    docker rmi -f ${IMAGE_ID};     
    fi;
done