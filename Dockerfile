
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV SUDO_FORCE_REMOVE yes

EXPOSE 8000

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    software-properties-common \
    sudo \
    curl && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \ 
    curl -sL https://deb.nodesource.com/setup_18.x -o /nodesource_setup.sh && \
    chmod 755 /nodesource_setup.sh && \
    /nodesource_setup.sh && \
    apt-get install --no-install-recommends -y \
    nodejs && \
    apt-get install --no-install-recommends -y \
    python3.9 \
    python3.9-distutils \
    python3-pip && \
    apt-get clean && \
    npm install -g configurable-http-proxy && \
    python3.9 -m pip install --upgrade pip && \
    python3.9 -m pip install \
    jupyterhub \
    jupyterlab && \
    python3.9 -m pip install \
    jupyterhub-nativeauthenticator && \ 
    apt-get remove -y \
    sudo \
    curl \ 
    python3.9-distutils \
    software-properties-common \
    python3-pip && \
    rm -f /nodesource.sh && \
    rm -rf /var/lib/apt/lists/* && \
    npm cache clean --force

ADD jupyterhub_config.py /etc/jupyterhub/

CMD jupyterhub -f /etc/jupyterhub/jupyterhub_config.py


