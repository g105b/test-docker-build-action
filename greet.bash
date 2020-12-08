#!/bin/bash
set -e
docker_tag="ghcr.io/g105b/test-docker-build-action:${ACTION_NAME}"
docker run --rm "$docker_tag"