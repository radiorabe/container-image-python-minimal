# RaBe Python Base Image Minimal

The RaBe Python Base Image Minimal is a stripped down image that uses microdnf as a package
manager and includes the latest python.

The image is based on the [RaBe Universal Base Image 8 Minimal](https://github.com/radiorabe/container-image-ubi8-minimal)
which is in turn based on the [Red Hat Universal Base Image 8 Minimal](https://catalog.redhat.com/software/containers/ubi8/ubi-minimal/5c359a62bed8bd75a2c3fba8)
container provided by Red Hat.

## Features

- Based on RaBe Universal Base Image 8 Minimal
- Contains the latest Python 3.x available in UBI8

## Usage

Create a downstream image from `ghcr.io/radiorabe/python-minimal`. Replace `:latest` with a specific version in the examples below.

```Dockerfile
FROM ghcr.io/radiorabe/python-minimal:latest AS build

COPY ./ /app/

RUN    cd /app \
    && python3 -mpip --no-cache-dir install wheel \
    && python3 setup.py bdist_wheel


FROM ghcr.io/radiorabe/python-minimal:latest AS app

COPY --from=build /app/dist/*.whl /tmp/dist/

RUN    python3 -mpip --no-cache-dir install /tmp/dist/*.whl \
    && rm -rf /tmp/dist/

USER nobody

CMD ["python3", "-mapp"]
```

The argument to `CMD` needs to call a Python module containing a `__main__` cli entrypoint. It is recommended that this is packaged as a [`console_scripts` style command line script](https://python-packaging.readthedocs.io/en/latest/command-line-scripts.html).

You can install os packages using microdnf. ie. if you use [setuptools-git-versioning](https://setuptools-git-versioning.readthedocs.io/en/stable/) you
would install `git-core` to make it work.

```Dockerfile
FROM ghcr.io/radiorabe/python-minimal:latest AS build

COPY ./ /app/

RUN    cd /app \
    && microdnf install git-core \
    && python3 -mpip --no-cache-dir install setuptools-git-versioning wheel \
    && python3 setup.py bdist_wheel


FROM ghcr.io/radiorabe/python-minimal:latest AS app

# ... same as in first example
```

In some cases it can make sense to install some Python requirements as os dependencies. An example would be the postgresql driver that needs to be built against an os postgresql driver and should not be based on a manylinux build from pypi in production.

```Dockerfile
FROM ghcr.io/radiorabe/python-minimal:latest AS build

# ... same as in first example

FROM ghcr.io/radiorabe/python-minimal:latest AS app

RUN    microdnf install python39-psycopg2 \
    && microdnf clean all \
    && python3 -mpip --no-cache-dir install /tmp/dist/*.whl \
    && rm -rf /tmp/dist/

COPY --from=build /app/dist/*.whl /tmp/dist/

USER nobody

CMD ["python3", "-mapp"]
```

In addition to building the container like this, the application needs to ensure that they pin a psycopg2 version range that includes the one provided by the os.
You can validate this by checking the output of the container image build which should not contain a `Downloading psycopg2*.whl` line in the `app` containers `python3 -mpip install` phase. 

## Release Management

The CI/CD setup uses semantic commit messages following the [conventional commits standard](https://www.conventionalcommits.org/en/v1.0.0/).
There is a GitHub Action in [.github/workflows/semantic-release.yaml](./.github/workflows/semantic-release.yaml)
that uses [go-semantic-commit](https://go-semantic-release.xyz/) to create new
releases.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit contains the following structural elements, to communicate intent to the consumers of your library:

1. **fix:** a commit of the type `fix` patches gets released with a PATCH version bump
1. **feat:** a commit of the type `feat` gets released as a MINOR version bump
1. **BREAKING CHANGE:** a commit that has a footer `BREAKING CHANGE:` gets released as a MAJOR version bump
1. types other than `fix:` and `feat:` are allowed and don't trigger a release

If a commit does not contain a conventional commit style message you can fix
it during the squash and merge operation on the PR.

## Build Process

The CI/CD setup uses the [Docker build-push Action](https://github.com/docker/build-push-action) to publish container images. This is managed in [.github/workflows/release.yaml](./.github/workflows/release.yaml).

## License

This application is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, version 3 of the License.

## Copyright

Copyright (c) 2022 [Radio Bern RaBe](http://www.rabe.ch)
