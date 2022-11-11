FROM ghcr.io/radiorabe/ubi8-minimal:0.5.0

RUN    microdnf install -y python39 \
    && microdnf clean all \