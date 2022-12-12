FROM ghcr.io/radiorabe/ubi9-minimal:0.1.1

RUN    microdnf install -y python3 \
    && microdnf clean all \
