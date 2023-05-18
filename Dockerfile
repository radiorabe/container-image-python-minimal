FROM ghcr.io/radiorabe/ubi9-minimal:0.3.0

RUN    microdnf install -y \
         python3.11 \
         python3.11-pip \
    && microdnf clean all \
    && ln /usr/bin/python3.11 /usr/bin/python \
    && ln /usr/bin/pydoc3.11 /usr/bin/pydoc \
    && ln /usr/bin/pip3.11 /usr/bin/pip
