# Contribution

PRs are always welcome!
Please make sure your editor has [editorconfig support](https://editorconfig.org/).

If you're sending a PR, please make sure maintainers are allowed to edit the PR.
This allows us to bump up the `version_file` before accepting your PR.

## Versioning guide
Builds on this repository are [semantically versioned](https://semver.org/).
Current build number is specified in the `version_file`

## Building an image locally
Running `hooks/build` should create an image for this repository

### Running tests
This image does not have any tests yet :( We're accepting PRs to help fix this.

## Building an image for docker hub
We are using docker cloud to automatically build all commits to the `main` branch.
