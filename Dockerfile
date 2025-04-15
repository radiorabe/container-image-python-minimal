FROM ghcr.io/radiorabe/ubi9-minimal:0.8.3

RUN    microdnf install -y \
         python3.12 \
    && microdnf clean all \
    && ln /usr/bin/python3.12 /usr/bin/python \
    && ln /usr/bin/pydoc3.12 /usr/bin/pydoc
