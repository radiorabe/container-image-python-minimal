FROM ghcr.io/radiorabe/ubi8-minimal:1.0.4

RUN    microdnf install -y python39 \
    && microdnf clean all \