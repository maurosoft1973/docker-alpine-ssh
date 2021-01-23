#!/bin/sh
#Descriptn: Execute remote command

# Default values of arguments
SSH_SERVER=${SSH_SERVER:-"localhost"}
SSH_USER=${SSH_USER:-"root"}
SSH_PASSWORD=${SSH_PASSWORD:-"root"}
DIRECTORY=${DIRECTORY:-""}

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -s=*|--server=*)
        SSH_SERVER="${arg#*=}"
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
        -d=*|--directory=*)
        DIRECTORY="${arg#*=}"
        shift # Remove
        ;;
        -h|--help)
        echo -e "usage "
        echo -e "$0 "
        echo -e "  -s=|--server=${SSH_SERVER} -> remote server (SSH_SERVER)"
        echo -e "  -u=|--user=${SSH_USER} -> user (SSH_USER)"
        echo -e "  -p=|--password=${SSH_PASSWORD} -> password (SSH_PASSWORD)"
        echo -e "  -d=|--directory=${DIRECTORY} -> directory (DIRECTORY)"
        exit 0
        ;;
    esac
done

if [ "$SSH_PASSWORD" == "" ]; then
    ssh -T ${SSH_USER}@${SSH_SERVER} "sudo mkdir -p ${DIRECTORY}"
else
    sshpass -p $SSH_PASSWORD ssh -T ${SSH_USER}@${SSH_SERVER} "mkdir -p ${DIRECTORY}"
fi