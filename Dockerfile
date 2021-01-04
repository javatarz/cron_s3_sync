FROM alpine:3.12.3

# Build labels
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION
ARG SOURCE_BRANCH
ARG SOURCE_REPOSITORY_URL="https://github.com/javatarz/cron_s3_sync"

# Labels
# Ref: https://rehansaeed.com/docker-labels-depth/
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.authors="javatarz"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/javatarz/cron_s3_sync"
LABEL org.opencontainers.image.documentation="${SOURCE_REPOSITORY_URL}/blob/main/README.md"
LABEL org.opencontainers.image.source="${SOURCE_REPOSITORY_URL}"
LABEL org.opencontainers.image.version="${BUILD_VERSION}"
LABEL org.opencontainers.image.revision="${VCS_REF}"
LABEL org.opencontainers.image.vendor="javatarz"
LABEL org.opencontainers.image.licenses="APL v2.0"
LABEL org.opencontainers.image.ref.name="cron_s3_sync"
LABEL org.opencontainers.image.title="Cron based S3 sync"
LABEL org.opencontainers.image.description="Run periodic sync to s3 using cron"
LABEL me.karun.image.branch="$SOURCE_BRANCH"

VOLUME [ "/data" ]

RUN apk add --no-cache python3 py3-pip tini && \
  pip3 install --upgrade pip && \
  pip3 install awscli
ENTRYPOINT [ "/sbin/tini", "--" ]

ADD sync.sh /sync.sh
RUN chmod +x /sync.sh

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD [ "/entrypoint.sh" ]
