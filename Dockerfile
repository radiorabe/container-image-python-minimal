FROM ghcr.io/radiorabe/ubi9-minimal:0.2.0

RUN    microdnf install -y python3 \
    && microdnf clean all \
