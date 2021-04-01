#!/bin/bash
# Description: Script for alpine ssh container
# Maintainer: Mauro Cardillo
#
echo "Get Remote Environment Variable"
wget -q "https://gitlab.com/maurosoft1973-docker/alpine-variable/-/raw/master/.env" -O ./.env
source ./.env

echo "Get Remote Settings"
wget -q "https://gitlab.com/maurosoft1973-docker/alpine-variable/-/raw/master/settings.sh" -O ./settings.sh
chmod +x ./settings.sh
source ./settings.sh

# Default values of arguments
IMAGE=maurosoft1973/alpine-ssh
IMAGE_TAG=latest
CONTAINER=alpine-ssh
LC_ALL=it_IT.UTF-8
TIMEZONE=Europe/Rome
SSH_SERVER=localhost
SSH_PORT=22
SSH_USER=root
SSH_PASSWORD=root
SSH_KEY_PRIVATE=

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -it=*|--image-tag=*)
        IMAGE_TAG="${arg#*=}"
        shift # Remove
        ;;
        -cn=*|--container=*)
        CONTAINER="${arg#*=}"
        shift # Remove
        ;;
        -cl=*|--lc_all=*)
        LC_ALL="${arg#*=}"
        shift # Remove
        ;;
        -ct=*|--timezone=*)
        TIMEZONE="${arg#*=}"
        shift # Remove
        ;;
        -s=*|--server=*)
        SSH_SERVER="${arg#*=}"
        shift # Remove
        ;;
        -P=*|--port=*)
        SSH_PORT="${arg#*=}"
        shift # Remove
        ;;
        -u=*|--user=*)
        SSH_USER="${arg#*=}"
        shift # Remove
        ;;
        -p=*|--password=*)
        SSH_PASSWORD="${arg#*=}"
        shift # Remove
        ;;
        -k=*|--private_key=*)
        SSH_PRIVATE_KEY="${arg#*=}"
        shift # Remove
        ;;
        -h|--help)
        echo -e "usage "
        echo -e "$0 "
        echo -e "  -it=|--image-tag -> ${IMAGE}:${IMAGE_TAG} (image with tag)"
        echo -e "  -cn=|--container -> ${CONTAINER} (container name)"
        echo -e "  -cl=|--lc_all -> ${LC_ALL} (container locale)"
        echo -e "  -ct=|--timezone -> ${TIMEZONE} (container timezone)"
        echo -e "  -s=|--server -> ${SSH_SERVER} (ssh remote server)"
        echo -e "  -P=|--port -> ${SSH_PORT} (ssh remote port)"
        echo -e "  -u=|--user -> ${SSH_USER} (ssh remote user)"
        echo -e "  -p=|--password -> ${SSH_PASSWORD} (ssh remote password)"
        echo -e "  -k=|--private_key -> ${SSH_PRIVATE_KEY} (ssh private key)"
        exit 0
        ;;
    esac
done

echo "# Image                   : ${IMAGE}:${IMAGE_TAG}"
echo "# Container Name          : ${CONTAINER}"
echo "# Container Locale        : ${LC_ALL}"
echo "# Container Timezone      : ${TIMEZONE}"
echo "# SSH Server              : ${SSH_SERVER}"
echo "# SSH Port                : ${SSH_PORT}"
echo "# SSH User                : ${SSH_USER}"
echo "# SSH Password            : ${SSH_PASSWORD}"
echo "# SSH Private Key         : ${SSH_PRIVATE_KEY}"

echo -e "Check if container ${CONTAINER} exist"
CHECK=$(docker container ps -a | grep ${CONTAINER} | wc -l)
if [ ${CHECK} == 1 ]; then
    echo -e "Stop Container -> ${CONTAINER}"
    docker stop ${CONTAINER} > /dev/null

    echo -e "Remove Container -> ${CONTAINER}"
    docker container rm ${CONTAINER} > /dev/null
else 
    echo -e "The container ${CONTAINER} not exist"
fi

echo -e "Create and run container"
docker run -dit --name ${CONTAINER} -e LC_ALL=${LC_ALL} -e TIMEZONE=${TIMEZONE} -e SSH_SERVER=${SSH_SERVER} -e SSH_PORT=${SSH_PORT} -e SSH_USER=${SSH_USER} -e SSH_PASSWORD=${SSH_PASSWORD} -e SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" ${IMAGE}:${IMAGE_TAG}

echo -e "Sleep 5 second"
sleep 5

IP=$(docker exec -it ${CONTAINER} /sbin/ip route | grep "src" | awk '{print $7}')
echo -e "IP Address is: ${IP}";

echo -e ""
echo -e "Environment variable";
docker exec -it ${CONTAINER} env

echo -e ""
echo -e "Container Logs"
docker logs ${CONTAINER}

rm -rf ./.env
rm -rf ./settings.sh

echo -e "Container attach"
docker attach ${CONTAINER}
