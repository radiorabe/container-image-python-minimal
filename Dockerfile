FROM ghcr.io/radiorabe/ubi9-minimal:0.11.5@sha256:2c50f165eccd206b3ff9c117c05df3b2263000b60cdd3ea24810b1c38bbe36b8

RUN    microdnf install -y \
         python3.12 \
    && microdnf clean all \
    && ln /usr/bin/python3.12 /usr/bin/python \
    && ln /usr/bin/pydoc3.12 /usr/bin/pydoc
