# docker-rclone-cron

A lightweight Docker image (arm64) running **rclone** as a **cron** job.

[Rclone](https://rclone.org/) is configurable with environment [variables](https://rclone.org/docs/#environment-variables).

## Usage

```
docker run \
    -v ./backups/:/backups/ \
    -e "CRON_SCHEDULE=0 0 * * *" \
    -e "COMMAND=rclone copy /backups/ MYREMOTE:/path/where/to/backup/" \
    ghcr.io/jplegat/rclone_cron:arm64
```

`COMMAND` is executed once on container startup (to test the config), and if sucessful, `cron` will start in foreground.

Please see the `rclone` documentation for the syntax and `RCLONE_CONFIG_*` configuration. See `cron` documentation for `CRON_SCHEDULE`.

## Sample Docker Compose

Example `docker-compose.yml` to sync local mount points.

```
services:
  backup:
    image: ghcr.io/jplegat/rclone_cron:arm64
    container_name: rclone_cron
    restart: unless-stopped
    environment:
      - CRON_SCHEDULE=30 13 * * *
      - COMMAND=rclone sync --multi-thread-streams=32 -P -L --metadata /mnt/SMB
        /mnt/BKP
    volumes:
      - /mnt/BKP:/mnt/BKP
      - /mnt/SMB:/mnt/SMB
```

Useful links:

### [crontab guru](https://crontab.guru/)
