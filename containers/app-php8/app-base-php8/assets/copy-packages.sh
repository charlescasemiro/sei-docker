#!/bin/bash

set -e

#!/bin/bash

mkdir -p /tmp/assets/pacotes
cd /tmp/assets/pacotes

wget https://github.com/charlescasemiro/sei-docker-binarios/raw/main/pacoteslinux/msttcore-fonts-2.0-3.noarch.rpm
wget https://github.com/charlescasemiro/sei-docker-binarios/blob/main/pacoteslinux/instantclient-precomp-linux.leppc64.c64-19.3.0.0.0dbru.zip
wget https://github.com/charlescasemiro/sei-docker-binarios/blob/main/pacoteslinux/instantclient-sdk-aix.ppc64-19.23.0.0.0dbru.zip
wget https://github.com/charlescasemiro/sei-docker-binarios/blob/main/pacoteslinux/instantclient-sqlplus-aix.ppc64-19.23.0.0.0dbru.zip
wget https://github.com/charlescasemiro/sei-docker-binarios/blob/main/pacoteslinux/uploadprogress-2.0.2.tgz

cd -