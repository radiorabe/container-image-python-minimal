FROM ghcr.io/radiorabe/ubi8-minimal:1.1.0

RUN    microdnf install -y python39 \
    && microdnf clean all \