FROM alpine:3.9

ARG RCLONE_VERSION=1.69.2

# install rclone
RUN apk add --no-cache wget ca-certificates && \
    wget -q https://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-arm64.zip && \
    unzip rclone-v${RCLONE_VERSION}-linux-arm64.zip && \
    mv rclone-v${RCLONE_VERSION}-linux-arm64/rclone /usr/bin && \
    rm rclone-v${RCLONE_VERSION}-linux-arm64.zip && \
    rm -rf rclone-v${RCLONE_VERSION}-linux-arm64 && \
    apk del wget

# install entrypoint
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# defaults env vars
ENV CRON_SCHEDULE="0 0 * * *"
ENV COMMAND="rclone version"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["crond", "-f"]
