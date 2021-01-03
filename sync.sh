#!/bin/sh

set -e

echo "> Sync job started: $(date)"
echo ">> Params: $PARAMS"
echo ">> Source: $DATA_PATH"
echo ">> Target: $S3_PATH"
echo

aws s3 sync $PARAMS "$DATA_PATH" "$S3_PATH"

echo
echo "> Sync job finished: $(date)"
