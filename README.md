# SSH Client Docker image running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/maurosoft1973/alpine-ssh.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/maurosoft1973/alpine-ssh/)
[![Docker Pulls](https://img.shields.io/docker/pulls/maurosoft1973/alpine-ssh.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/maurosoft1973/alpine-ssh/)
[![Docker Stars](https://img.shields.io/docker/stars/maurosoft1973/alpine-ssh.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/maurosoft1973/alpine-ssh/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.13.3-green.svg?style=for-the-badge)](https://alpinelinux.org/)

The Docker images [(maurosoft1973/alpine-ssh)](https://hub.docker.com/r/maurosoft1973/alpine-ssh/) is based on the minimal [Alpine Linux](https://alpinelinux.org/) with [SSH Version v](https://www.openssh.com).

##### Alpine Version 3.13.3 (Released Mar 25, 2021)
##### SSH Client Version  (Released )

## Description
OpenSSH is the premier connectivity tool for remote login with the SSH protocol. It encrypts all traffic to eliminate eavesdropping, connection hijacking, and other attacks. In addition, OpenSSH provides a large suite of secure tunneling capabilities, several authentication methods, and sophisticated configuration options.

The OpenSSH suite consists of the following tools:

- Remote operations are done using ssh, scp, and sftp
- Key management with ssh-add, ssh-keysign, ssh-keyscan, and ssh-keygen.
- The service side consists of sshd, sftp-server, and ssh-agent.

OpenSSH is developed by a few developers of the OpenBSD Project and made available under a BSD-style license.

OpenSSH is incorporated into many commercial products, but very few of those companies assist OpenSSH with funding.

To make it easier to use, the image contains the following commands:
- ssh_remote_chmod : is the command used to change the access permissions of file system objects (files and directories).For help and parameter, ssh_remote_chmod -h
- ssh_remote_chown : is the command for change the owner of file system files, directories.For help and parameter, ssh_remote_chown -h
- ssh_remote_command: is the command for executed all bash command.For help and parameter, ssh_remote_command -h
- ssh_remote_mkdir: is the command used to make a new directory.For help and parameter, ssh_remote_mkdir -h
- ssh_remote_rm: is the command user to remove directory.For help and parameter, ssh_remote_rm -h

## Architectures

* ```:amd64```, ```:x86_64``` - 64 bit Intel/AMD (x86_64/amd64)

## Tags

* ```:latest``` latest branch based (Automatic Architecture Selection)
* ```:amd64```, ```:x86_64```  amd64 based on latest tag but amd64 architecture

## Layers & Sizes

![Version](https://img.shields.io/badge/version-amd64-blue.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/maurosoft1973/alpine-ssh?style=for-the-badge)

## Environment Variables:

### Main SSH parameters:
* `LC_ALL`: default locale (en_GB.UTF-8)
* `TIMEZONE`: default timezone (Europe/Brussels)
* `SSH_SERVER`: remote ssh server
* `SSH_PORT`: remote ssh port
* `SSH_USER`: remote ssh user
* `SSH_PASSWORD`: remote ssh password
* `SSH_PRIVATE_KEY`: the ssh private key associate at the user

## Sample Use with gitlab pipeline (access remote server with user and password)

```yalm
stages:
    - ssh

ssh-test:
    stage: ssh
    image: maurosoft1973/alpine-ssh
    variables:
        SSH_SERVER: 'ssh server'
        SSH_PORT: '22'
        SSH_USER: 'ssh remote user'
        SSH_PASSWORD: 'ssh remote password'
    only:
        - master
    script:
        - echo "Check Uptime"
        - ssh_remote_command -c="uptime"
        - echo "Restart rsyslog Service"
        - ssh_remote_command -c="service restart rsyslogs"
        - echo "Create Remote Director /var/www/pippo"
        - ssh_remote_mkdir "/var/www/pippo"
        - echo "Store the result command into local variable"
        - DF=$(ssh_remote_command -c="df -h")
```

## Sample Use with gitlab pipeline (access remote server with user and private key)

```yalm
stages:
    - ssh

ssh-test:
    stage: ssh
    image: maurosoft1973/alpine-ssh
    variables:
        SSH_SERVER: 'ssh server'
        SSH_PORT: '22'
        SSH_USER: 'ssh remote user'
        SSH_PRIVATE_KEY: 'ssh privaye key of user'
    only:
        - master
    script:
        - echo "Check Uptime"
        - ssh_remote_command -c="uptime"
        - echo "Restart rsyslog Service"
        - ssh_remote_command -c="service restart rsyslogs"
        - echo "Create Remote Director /var/www/pippo"
        - ssh_remote_mkdir "/var/www/pippo"
```

***
###### Last Update 01.04.2021 10:02:39
