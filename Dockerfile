FROM ghcr.io/radiorabe/ubi8-minimal:1.0.5

RUN    microdnf install -y python39 \
    && microdnf clean all \