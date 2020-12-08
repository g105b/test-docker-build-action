Test Docker Build Action
========================

This is a test repository that I'm using to document the process of building a Github Action that builds a customised Docker image, according to the action's input.

The example repository that uses this action is located here: https://github.com/g105b/example-test-docker-build-action.

This technique is used in [php-actions](https://github.com/php-actions) so that each action can specify its own version of PHP, which extensions are installed, and the version of the component being run inside the action (Composer, PHPUnit, etc.). It is greatly simplified in this repository to help me and others when building similar actions.

Step by step
------------

1. Inputs `php_version` and `name` are specified in the `action.yml` of this repository.
2. The inputs are passed to two bash scripts that execute within the context of the repository.
3. The first script, `docker-build.bash` creates a `Dockerfile` on-the-fly, which sets the environment for the runner according to the inputs. In this case, it sets the `GREETER_NAME` environment variable according to the passed in action `input.name`.
4. The first script then builds the customised Docker image, tags it with a unique tag name and pushes it to Github Container Registry.
5. The second script, `greet.bash` simply runs the Docker image with the specific tag, which should be pre-cached in Github's action runner. The Docker image executes a PHP script that greets the user according to what is stored within the environment variable.

This is a very trivial example, but it covers the basic requirements of what is needed within the php-actions repositories: a slightly customised Docker image according to action input, and caching of the custom Docker image for fast builds.

***

If you found this repository helpful, please consider [sponsoring the developer][sponsor].

https://github.com/sponsors/g105b