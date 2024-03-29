FROM alpine:3.19.0

ARG BUILD_DATE

LABEL org.opencontainers.image.title="Gitea - Git with a cup of tea"
LABEL org.opencontainers.image.description="A painless self-hosted Git service."
LABEL org.opencontainers.image.version="1.21.2"
LABEL org.opencontainers.image.url="https://gitea.io"
LABEL org.opencontainers.image.authors="Tamás Gérczei <tamas@gerczei.eu>"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.source="https://git.gerczei.eu/tgerczei/gitea-alpine"
LABEL org.opencontainers.image.vendor="Gérczei Tamás"

ADD https://git.gerczei.eu/api/packages/tgerczei/alpine/key /etc/apk/keys/tgerczei@a6d5511b4c93844ff5ab30b8c04ded788463887b193bbd12d1410ef81967ed84.rsa.pub

# using a community package re-built locally via apkbuild with MySQL support
RUN     apk add --repository https://git.gerczei.eu/api/packages/tgerczei/alpine/v3.19/gitea-alpine --no-cache \
                git-lfs=3.4.0-r1 \
                openssh-keygen=9.5_p1-r0 \
                bash=5.2.21-r0 \
                gitea=1.21.2-r0 && \
        mkdir /var/cache/gitea && \
        chown gitea:www-data /var/cache/gitea

EXPOSE 22 3000

USER gitea:www-data

ENTRYPOINT ["/usr/bin/gitea"]

CMD ["web", "-c", "/etc/gitea/conf/app.ini"]
