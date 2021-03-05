#!/bin/sh

source /scripts/init-alpine.sh

mkdir -p ~/.ssh && chmod 700 ~/.ssh
touch ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

SSH_PRIVATE_KEY=${SSH_PRIVATE_KEY:-""}
if [[ -z ${SSH_PRIVATE_KEY} ]]; then
    echo -e "SSH Private Key Not Defined"
else
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
fi

/bin/sh
