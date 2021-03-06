#!/usr/bin/env bash
# Setup script
setup() {
  :
  # Unofficial bash strictmode - http://redsymbol.net/articles/unofficial-bash-strict-mode/
  set -euo pipefail
  IFS=$'\n\t'

  # Directory of the executed script
  SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
  ls -lah

  # Delightful git commands
  GIT_REPO=$(git rev-parse --show-toplevel)
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  GIT_HASH=$(git rev-parse HEAD)
  GIT_SHORT_HASH=$(git rev-parse --short HEAD)
  GIT_DESCRIBE=$(git describe --dirty --tags --long)
  GIT_VERSION=$(git describe --tags --abbrev=0 --match "v[0-9]*")
}

run() {
  echo "$0"
  docker build -f "$GIT_REPO/Dockerfile" -t madlib "$GIT_REPO"

  docker tag madlib onescriptkid/madlib:latest
  docker tag madlib onescriptkid/madlib:"$GIT_SHORT_HASH"
  docker tag madlib onescriptkid/madlib:"$GIT_DESCRIBE"
  docker tag madlib onescriptkid/madlib:"$GIT_VERSION"
}

setup
run