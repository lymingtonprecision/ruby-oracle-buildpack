aharper/ruby-oracle-buildpack
=============================

Base Docker image to create containers from app code using Heroku's Ruby
buildpack with the addition of the Oracle Instant Client (version 12.1.0.2.0)
to enable use of the ruby-oci8 gem.

## Setup

After cloning the repository you will need to download the [Oracle
Instant Client][oic] installation files.

[oic]: http://www.oracle.com/technetwork/database/features/instant-client/

Download the latest *basic* and *sdk* zip files for your platform (i.e.
`linux x86` or `linux x86_64`) into the `build/resources` directory.

Build the Docker image:

    docker build -t myorg/ruby-oracle-buildpack .

## Usage

Create a `Dockerfile` similar to the following in your application folder:

    FROM aharper/ruby-oracle-buildpack
    MAINTAINER Your Name <your@email.addr>
    CMD ["/exec", "bundle", "exec", "rackup", "-c", "config.ru", "-p", "$PORT"]

Or, if you have a `Procfile`:

    CMD ["/start", "-p", "$PORT"]

Then, build the image:

    docker build -t myuser/myapp .

... and run it:

    docker run -d -p 80:5000 myuser/myapp

Done!

## Things to Note

### Building

If you are building from a `Dockerfile` in a Git repository the current
HEAD of the master branch will be cloned into the image. You can override
this by adding a `GIT_BRANCH` to the `Dockerfile`:

    ENV GIT_BRANCH my-cool-branch
    FROM lpe/ruby-oracle-buildpack
    ...

Note that you must specify it _before_ the `FROM` line.

This variable can be set to any valid value for the `--branch` argument
to `git clone` (e.g. a specific tag.)

(If you are not building from a Git repository then the current directory
is copied to the image as is.)

### Executing

There are two utility scripts installed in the root of the container:

* `exec` which runs a command in your applications environment
* `start` which is just an alias for `/exec foreman start ...`

[Foreman] is installed to facilitate use of `Procfile`s and the `PORT`
environment variable is set to a default value of `5000`. Be mindful of
Foreman's port assignment strategy when configuring port mappings to/from
the container.

[Foreman]: http://ddollar.github.io/foreman/

If your application does not have a `Procfile` one will be created from
the Heroku buildpack.


References & Credit
-------------------

This is largely based upon the following projects:

* [progrium/buildstep](https://github.com/progrium/buildstep)
* [tutumcloud/buildstep](https://github.com/tutumcloud/buildstep)

... and the [Heroku Buildpacks on Docker][heroku-docker] post on the Docker blog.

[heroku-docker]: http://blog.docker.com/2013/05/heroku-buildpacks-on-docker/
