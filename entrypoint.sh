#!/bin/sh

set -e

if [ -z "$PARAMS" ];
then
PARAMS=""
echo "Optional variable PARAMS was not set. Using default value: '$PARAMS'"
fi

if [ -z "$DATA_PATH" ];
then
DATA_PATH="/data"
echo "Optional variable DATA_PATH was not set. Using default value: '$DATA_PATH'"
fi

if [ -z "$S3_PATH" ];
then
echo "S3_PATH is required but was not found"
exit 10
fi

if [ -z "$CRON_SCHEDULE" ];
then
echo "CRON_SCHEDULE is required but was not found"
exit 11
fi

if [ -z "$AWS_ACCESS_KEY_ID" ];
then
echo "AWS_ACCESS_KEY_ID is required but was not found"
exit 21
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ];
then
echo "AWS_SECRET_ACCESS_KEY is required but was not found"
exit 22
fi

if [[ "$1" == 'no-cron' ]]; then
    exec /sync.sh
else
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi
    CRON_ENV="PARAMS='$PARAMS'"
    CRON_ENV="$CRON_ENV DATA_PATH='$DATA_PATH'"
    CRON_ENV="$CRON_ENV S3_PATH='$S3_PATH'"
    CRON_ENV="$CRON_ENV AWS_ACCESS_KEY_ID='$AWS_ACCESS_KEY_ID'"
    CRON_ENV="$CRON_ENV AWS_SECRET_ACCESS_KEY='$AWS_SECRET_ACCESS_KEY'"

    echo ">> Writing sync command to crontab"
    echo "$CRON_SCHEDULE $CRON_ENV /sync.sh > $LOGFIFO 2>&1" | crontab -

    echo ">> Run crond in background"
    crond

    echo ">> Cron log"
    tail -f "$LOGFIFO"
fi
