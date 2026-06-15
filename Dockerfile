FROM ghcr.io/radiorabe/ubi9-minimal:0.12.0@sha256:ddf3ac33c48b5005cc325732cb547279a926f29b3db9adcbd844f1cf94dcf831

RUN    microdnf install -y \
         python3.12 \
    && microdnf clean all \
    && ln /usr/bin/python3.12 /usr/bin/python \
    && ln /usr/bin/pydoc3.12 /usr/bin/pydoc
