FROM ghcr.io/radiorabe/ubi9-minimal:0.3.0

RUN    microdnf install -y python3 \
    && microdnf clean all \