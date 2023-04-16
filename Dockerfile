FROM ubuntu:focal

USER root

LABEL org.opencontainers.image.authors="george.pickers@coralogix.com,george.boddey@coralogix.com"

COPY . /

# Update and install dependencies
RUN apt-get update -y && \
    apt install -y \
    git \
    sudo \
    curl \
    # systemctl \
    # procps \
    python3-pip && \
    apt -y autoremove && apt -y autoclean && apt -y clean && \
    sudo curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh

# Install td-agent CEF parser
RUN td-agent-gem install fluent-plugin-parser_cef

# Git clone Fake-ELB-Log-Generator
RUN git clone https://github.com/kekayan/Fake-ELB-Log-Generator

# Git clone Apache-Fake-Log-Generator
RUN git clone https://github.com/tuanpembual/Fake-Apache-Log-Generator

# Install pip dependencies
RUN pip install -r /Fake-Apache-Log-Generator/requirements.txt

RUN ["/bin/sh", "-c","sh /data/log_gen.sh"]