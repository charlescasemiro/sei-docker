################################################################################
# Dockerfile de construcao do container APP com os pacotes basicos
################################################################################

ARG IMAGEM_BASE=docker.io/redhat/ubi8:latest

FROM ${IMAGEM_BASE}

ARG IMAGEM_APP_PACOTEMYSQL_PRESENTE=true
ARG IMAGEM_APP_PACOTESQLSERVER_PRESENTE=true
ARG IMAGEM_APP_PACOTEORACLE_PRESENTE=true
ARG IMAGEM_APP_PACOTEPOSTGRES_PRESENTE=true

ENV TERM="xterm" \
    LANG="pt_BR.ISO-8859-1"

ADD assets /tmp/assets

RUN chmod +x /tmp/assets/*.sh

RUN yum clean all && \
    yum -y update

# Instalação dos componentes básicos do servidor web apache
RUN yum -y install \
    httpd \
    memcached \
    openssl \
    wget \
    curl \
    zip \
    unzip \
    gcc \
    java-1.8.0-openjdk \
    libxml2 \
    icoutils \
    libexif \
    xorg-x11-font-utils \
    xorg-x11-fonts-75dpi \
    fontconfig \
    mod_ssl

# Instalação do PHP e demais extenções necessárias para o projeto
RUN dnf install -y yum-utils

# Instalação do PHP e demais extenções necessárias para o projeto
RUN yum -y install \
    php php-common \
    php-cli \
    php-pear \
    php-bcmath \
    php-gd \
    php-gmp \
    php-intl \
    php-ldap \
    php-mbstring \
    php-odbc \
    php-pdo \
    php-pecl-apcu \
    php-zlib \
    php-snmp \
    php-soap \
    php-xml \
    php-xmlrpc \
    php-devel \
    php-pecl-apcu-devel \
    php-calendar \
    php-shmop \
    php-intl \
    php-zip \
    php-pecl-zip \
    git

RUN /tmp/assets/copy-packages.sh

RUN cp -v /tmp/assets/ca-certIN.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust extract
RUN update-ca-trust enable

RUN cd /tmp/assets/pacotes

# Instalação do componentes UploadProgress
RUN tar -zxvf uploadprogress.tgz
RUN cd uploadprogress
RUN phpize
RUN ./configure --enable-uploadprogress
RUN make
RUN make install
RUN echo "extension=uploadprogress.so" > /etc/php.d/uploadprogress.ini
RUN cd -

# fonts libraries
RUN rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm

RUN /tmp/assets/install.sh

RUN rm -rf /tmp/assets