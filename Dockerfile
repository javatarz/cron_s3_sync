FROM alpine:3.12.3

# Build labels
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

# Labels
LABEL author="javatarz"
LABEL maintainer="javatarz"
LABEL url="github.com/javatarz/cron_s3_sync"
LABEL vcs-ref="github.com/javatarz/cron_s3_sync"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="cron_s3_sync"
LABEL org.label-schema.description="Run periodic sync to s3 using cron"
LABEL org.label-schema.url="https://karun.me/"
LABEL org.label-schema.vcs-url="https://github.com/javatarz/cron_s3_sync"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="javatarz"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run -e S3_PATH=<target> -e CRON_SCHEDULE=<schedule> -e AWS_ACCESS_KEY_ID=<key> -e AWS_SECRET_ACCESS_KEY=<secret> -v <source>:/data javatarz/cron_s3_sync"

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
