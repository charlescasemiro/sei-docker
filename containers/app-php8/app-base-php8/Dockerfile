################################################################################
# Dockerfile de construcao do container APP com os pacotes basicos
################################################################################

ARG IMAGEM_BASE=docker.io/php:8.2.21-fpm-alpine

FROM ${IMAGEM_BASE}

ARG IMAGEM_APP_PACOTEMYSQL_PRESENTE=true
ARG IMAGEM_APP_PACOTESQLSERVER_PRESENTE=false
ARG IMAGEM_APP_PACOTEORACLE_PRESENTE=false
ARG IMAGEM_APP_PACOTEPOSTGRES_PRESENTE=true

ENV TERM="xterm" \
    LANG="pt_BR.ISO-8859-1"

ADD assets /tmp/assets

RUN /tmp/assets/copy-packages.sh && \
    /tmp/assets/install.sh && \
    rm -rf /tmp/assets