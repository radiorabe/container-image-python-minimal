FROM ghcr.io/radiorabe/ubi8-minimal:0.2.1

RUN    microdnf install -y python39 \
    && microdnf clean all \