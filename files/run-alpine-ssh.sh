#!/bin/sh

source /scripts/init-alpine.sh

mkdir -p ~/.ssh && chmod 700 ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

SSH_PRIVATE_KEY=${SSH_PRIVATE_KEY:-""}
if [[ -z ${SSH_PRIVATE_KEY} ]]; then
    echo -e "SSH Private Key Not Defined"
else
    echo $SSH_PRIVATE_KEY > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
fi

if [[ -z ${SSH_SERVER} ]]; then
    echo -e "SSH_SERVER Not Defined"
else 
    ssh-keyscan -H "${SSH_SERVER}" >> ~/.ssh/known_hosts
fi

/bin/sh
