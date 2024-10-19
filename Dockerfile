FROM ubuntu:24.04

# Metadata
LABEL description="Nextflow-based app to build consensus sequences from pod5 data."
LABEL base_image="ubuntu:24.04"
LABEL version="0.0.0"
LABEL github="https://github.com/ClementMoline/pod5consensus.git"
LABEL maintainer="Clément Moliné - molineclement@gmail.com"

# Basic Environment Variables
ENV TERM=xterm-256color

# Pre-requisites
ENV JDK_VER=21
RUN apt update && apt install -y --no-install-recommends \
        wget \
        openjdk-${JDK_VER}-jdk \
        && rm -rf /var/lib/apt/lists/* \
        && java -version

# Install Nextflow
WORKDIR /usr/local/bin/
ENV NXF_VER=24.04.4
RUN wget -qO- https://github.com/nextflow-io/nextflow/releases/download/v${NXF_VER}/nextflow-${NXF_VER}-all | /bin/bash \
    && chmod 755 nextflow \
    && nextflow info

# Install Docker
RUN apt update && apt install -y docker.io \
        && docker --version
