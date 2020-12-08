#!/bin/bash
set -e
docker pull -q "php:$ACTION_PHP_VERSION"
dockerfile="FROM php:$ACTION_PHP_VERSION"

GITHUB_USER=$(curl -sSL -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user | jq -r .login)
echo "DEBUG: Github username: $GITHUB_USER"

dockerfile="${dockerfile}
ENV GREETER_NAME=\"${ACTION_NAME}\"
ADD greeter.php /app/greeter.php
CMD php /app/greeter.php
"

ACTION_NAME_NO_SPACES="${ACTION_NAME// /_}"
# Tag the image with the name we've added, so it can be cached per-name.
docker_tag="ghcr.io/g105b/test-docker-build-action:${ACTION_PHP_VERSION}-${ACTION_NAME_NO_SPACES}"
docker pull "$docker_tag" || echo "Remote tag does not exist yet"

# Build the custom image and attempt to push it.
echo "$dockerfile" > Dockerfile
docker build --tag "$docker_tag" .
docker push "$docker_tag"