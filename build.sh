#!/bin/sh

build_date="$(date +"%Y-%m-%d %T")"
vcs_ref="$(git rev-parse HEAD)"
version=$1

if [ -z "$version" ];
then
echo "version is required but was not found"
exit 10
fi

docker build \
  --build-arg BUILD_DATE='$build_date' \
  --build-arg VCS_REF='$vcs_ref' \
  --build-arg BUILD_VERSION='$version' \
  --tag javatarz/cron_s3_sync:$version \
  --tag javatarz/cron_s3_sync:latest \
  .
