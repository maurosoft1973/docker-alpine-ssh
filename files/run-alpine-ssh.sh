#!/bin/sh

source /scripts/init-alpine.sh

mkdir -p ~/.ssh && chmod 700 ~/.ssh
touch ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

/bin/sh
