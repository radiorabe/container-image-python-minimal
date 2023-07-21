FROM ghcr.io/radiorabe/ubi9-minimal:0.5.0

RUN    microdnf install -y \
         python3.11 \
    && microdnf clean all \
    && ln /usr/bin/python3.11 /usr/bin/python \
    && ln /usr/bin/pydoc3.11 /usr/bin/pydoc
