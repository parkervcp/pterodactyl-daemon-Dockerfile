FROM node:10-alpine

MAINTAINER Michael Parker, <docker@parkervcp.com>

ENV DAEMON_VERSION=v0.6.11

COPY . /srv/daemon

WORKDIR /srv/daemon

RUN apk add --no-cache curl openssl make gcc g++ python linux-headers paxctl gnupg tar zip unzip coreutils zlib supervisor jq \
 && addgroup -S pterodactyl && adduser -S -D -H -G pterodactyl -s /bin/false pterodactyl \
 && curl -sSL https://github.com/Pterodactyl/Daemon/releases/download/${DAEMON_VERSION}/daemon.tar.gz -o daemon.tar.gz \
 && tar --strip-components=1 -xzvf daemon.tar.gz \
 && rm daemon.tar.gz \
 && npm install --production \
 && apk del --no-cache make gcc g++ python linux-headers paxctl gnupg \
 && mkdir -p /var/log/supervisord /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
 && curl -sSL https://github.com/pterodactyl/sftp-server/releases/download/$(curl --silent "https://api.github.com/repos/pterodactyl/sftp-server/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/sftp-server > /srv/daemon/sftp-server \
 && chmod +x /srv/daemon/sftp-server \
 && chmod +x /srv/daemon/entrypoint.sh \
 && cp /srv/daemon/supervisord.conf /etc/supervisord.conf

ENTRYPOINT [ "/bin/ash", "/srv/daemon/entrypoint.sh" ]

CMD [ "supervisord", "-n", "-c", "/etc/supervisord.conf" ]
