#!/bin/bash
set -e
docker pull -q "php:$ACTION_PHP_VERSION"
dockerfile="FROM php:$ACTION_PHP_VERSION"

# Create the greeting as a file, so it can be added to the custom Docker image.
touch name.txt
echo "$ACTION_NAME" > name.txt
dockerfile="${dockerfile}
ADD name.txt /tmp/name.txt"

# Tag the image with the name we've added, so it can be cached per-name.
docker_tag="ghcr.io/g105b/test-docker-build-action:${ACTION_NAME}"
docker pull "$docker_tag" || echo "Remote tag does not exist"

# Build the custom image and attempt to push it.
echo "$dockerfile" | docker build --tag "$docker_tag" -
docker push "$docker_tag"