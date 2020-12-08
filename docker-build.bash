#!/bin/bash
set -e
docker pull -q "php:$ACTION_PHP_VERSION"
dockerfile="FROM php:$ACTION_PHP_VERSION"

dockerfile="${dockerfile}
ENV GREETER_NAME=\"${ACTION_NAME}\"
ADD greeter.php /app/greeter.php
CMD php /app/greeter.php
"

# Tag the image with the name we've added, so it can be cached per-name.
docker_tag="ghcr.io/g105b/test-docker-build-action:${ACTION_NAME}"
docker pull "$docker_tag" || echo "Remote tag does not exist yet"

# Build the custom image and attempt to push it.
echo "$dockerfile" > Dockerfile
docker build --tag "$docker_tag" .
docker push "$docker_tag"