FROM mhart/alpine-node:6.8

MAINTAINER Michael Parker, <docker@parkervcp.com>

WORKDIR /srv/daemon

RUN apk update \
 && apk add openssl make gcc g++ python linux-headers paxctl gnupg zip unzip git \
 && git clone https://github.com/Pterodactyl/Daemon.git . \
 && npm install --production \
 && apk del curl make gcc g++ python linux-headers paxctl gnupg tar ${DEL_PKGS} \
 && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
 && rm -rf /node-${VERSION}.tar.gz /SHASUMS256.txt.asc /node-${VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

EXPOSE 8080

CMD ["npm", "start"]
