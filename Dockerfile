FROM alpine:3.12.0

ARG BUILD_DATE

LABEL org.opencontainers.image.title="Gitea - Git with a cup of tea"
LABEL org.opencontainers.image.description="A painless self-hosted Git service."
LABEL org.opencontainers.image.version="1.12.4"
LABEL org.opencontainers.image.url="https://gitea.io"
LABEL org.opencontainers.image.authors="Tamás Gérczei <tamas@gerczei.eu>"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.source="https://git.gerczei.eu/tgerczei/gitea-alpine"
LABEL org.opencontainers.image.vendor="Gérczei Tamás E.V."

ADD https://www.gerczei.eu/files/tamas@gerczei.eu-5ec0fe1e.rsa.pub /etc/apk/keys/

# using a community package re-built locally via apkbuild with MySQL support
RUN     apk add --repository https://www.gerczei.eu/packages/alpine/v3.12 --no-cache \
                git-lfs=2.11.0-r0 \
                openssh-keygen=8.3_p1-r0 \
                bash=5.0.17-r0 \
                gitea=1.12.4-r0 && \
        mkdir /var/cache/gitea && \
        chown gitea:www-data /var/cache/gitea

EXPOSE 22 3000

USER gitea:www-data

ENTRYPOINT ["/usr/bin/gitea"]

CMD ["web", "-c", "/etc/gitea/conf/app.ini"]
