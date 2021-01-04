# Backup directory to S3 on cron using docker

Sync a directory with S3 on cron.

Tiny [alpine](https://hub.docker.com/_/alpine) footprint with the latest [AWS CLI](https://pypi.org/project/awscli/) and [tini for house cleaning](https://github.com/krallin/tini/issues/8#issuecomment-146135930) which is available on [Docker Hub](https://hub.docker.com/r/javatarz/cron_s3_sync).

## Usage
### Docker Run
```bash
docker run \
  -e S3_PATH=<target> \
  -e CRON_SCHEDULE=<schedule> \
  -e AWS_ACCESS_KEY_ID=<key> \
  -e AWS_SECRET_ACCESS_KEY=<secret> \
  -v <source>:/data \
  javatarz/cron_s3_sync
```

### Docker compose
```yaml
  backup_to_s3:
    build: backup_to_s3
    container_name: backup_to_s3
    environment:
      - S3_PATH=s3://some-bucket
      - CRON_SCHEDULE=0 * * * *
    env_file:
      - ./secrets/backup_to_s3/env
    volumes:
      - ./data:/data
    restart: unless-stopped
```

## Environment variables

| Environment Variables   | Type      | Description
| :---------------------  | :-------- | :----
| `PARAMS`                | Optional  | `aws s3 sync --help`
| `DATA_PATH`             | Optional  | source directory to read from
| `S3_PATH`               | Mandatory | target for s3 sync
| `CRON_SCHEDULE`         | Mandatory | schedule as [supported by crontab](https://crontab.guru)
| `AWS_ACCESS_KEY_ID`     | Mandatory | Access key for AWS S3 writes
| `AWS_SECRET_ACCESS_KEY` | Mandatory | Secret key for AWS S3 writes
