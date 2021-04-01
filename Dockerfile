FROM maurosoft1973/alpine

ARG BUILD_DATE
ARG ALPINE_RELEASE
ARG ALPINE_RELEASE_REPOSITORY
ARG ALPINE_VERSION
ARG ALPINE_VERSION_DATE
ARG SSH_VERSION
ARG SSH_VERSION_DATE

LABEL \
    maintainer="Mauro Cardillo <mauro.cardillo@gmail.com>" \
    architecture="amd64/x86_64" \
    ssh-version="$SSH_VERSION" \
    alpine-version="$ALPINE_VERSION" \
    build="$BUILD_DATE" \
    org.opencontainers.image.title="alpine-ssh" \
    org.opencontainers.image.description="SSH Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Mauro Cardillo <mauro.cardillo@gmail.com>" \
    org.opencontainers.image.vendor="Mauro Cardillo" \
    org.opencontainers.image.version="v$SSH_VERSION" \
    org.opencontainers.image.url="https://hub.docker.com/r/maurosoft1973/alpine-ssh/" \
    org.opencontainers.image.source="https://github.com/maurosoft1973/alpine-ssh" \
    org.opencontainers.image.created=$BUILD_DATE

RUN \
    apk add --update --no-cache openssh-client ca-certificates sshpass curl rsync && \
    rm -rf /tmp/* /var/cache/apk/*

ADD files/ssh_remote_* /usr/local/sbin/
RUN chmod +x /usr/local/sbin/*

ADD files/run-alpine-ssh.sh /scripts/run-alpine-ssh.sh
RUN chmod +x /scripts/run-alpine-ssh.sh

ENTRYPOINT ["/scripts/run-alpine-ssh.sh"]
