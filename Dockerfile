FROM maurosoft1973/alpine

ARG BUILD_DATE

LABEL \
    maintainer="Mauro Cardillo <mauro.cardillo@gmail.com>" \
    architecture="amd64/x86_64" \
    alpine-version="3.12.3" \
    build="$BUILD_DATE" \
    org.opencontainers.image.title="alpine-ssh" \
    org.opencontainers.image.description="SSH Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Mauro Cardillo <mauro.cardillo@gmail.com>" \
    org.opencontainers.image.vendor="Mauro Cardillo" \
    org.opencontainers.image.url="https://hub.docker.com/r/maurosoft1973/alpine-lftp/" \
    org.opencontainers.image.source="https://github.com/maurosoft1973/alpine-lftp" \
    org.opencontainers.image.created=$BUILD_DATE

RUN \
    apk add --update --no-cache openssh-client ca-certificates sshpass curl rsync && \
    rm -rf /tmp/* /var/cache/apk/*

ADD files/ssh_remote_chmod.sh /usr/local/sbin/ssh_remote_chmod
RUN chmod +x /usr/local/sbin/ssh_remote_chmod

ADD files/ssh_remote_chown.sh /usr/local/sbin/ssh_remote_chown
RUN chmod +x /usr/local/sbin/ssh_remote_chown

ADD files/ssh_remote_command.sh /usr/local/sbin/ssh_remote_command
RUN chmod +x /usr/local/sbin/ssh_remote_command

ADD files/ssh_remote_mkdir.sh /usr/local/sbin/ssh_remote_mkdir
RUN chmod +x /usr/local/sbin/ssh_remote_mkdir

ADD files/ssh_remote_rm.sh /usr/local/sbin/ssh_remote_rm
RUN chmod +x /usr/local/sbin/ssh_remote_rm

ADD files/run-alpine-ssh.sh /scripts/run-alpine-ssh.sh
RUN chmod +x /scripts/run-alpine-ssh.sh

ENTRYPOINT ["/scripts/run-alpine-ssh.sh"]
