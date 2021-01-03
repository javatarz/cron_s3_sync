# Contribution

PRs are always welcome!
Please make sure your editor has [editorconfig support](https://editorconfig.org/).
This repository is manually built and published for now but soon will have an automated github action to do so.

## Building and deploying latest changes to docker hub

1. `docker login` to authenticate
2. `./build.sh <version>` to build and tag the latest image
3. `docker push -a javatarz/cron_s3_sync` to push the image to dockerhub

### Versioning guide
It's best to [semantically version](https://semver.org/) your builds.

