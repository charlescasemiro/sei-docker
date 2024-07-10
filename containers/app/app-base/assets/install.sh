#!/bin/bash

set -e

# Configuração do pacote de línguas pt_BR
#localedef pt_BR -i pt_BR -f ISO-8859-1
#localedef pt_BR.ISO-8859-1 -i pt_BR -f ISO-8859-1
#localedef pt_BR.ISO8859-1 -i pt_BR -f ISO-8859-1

# Instalação do componentes UploadProgress
cd /tmp/assets/pacotes/
tar -zxf /tmp/assets/pacotes/uploadprogress.tgz --no-same-owner
cd ./uploadprogress
phpize
./configure --enable-uploadprogress
make
make install
echo "extension=uploadprogress.so" > /etc/php.d/uploadprogress.ini
cd -

# fonts libraries
rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm


if [ "$IMAGEM_APP_PACOTEMYSQL_PRESENTE" == "true" ]; then

  yum install -y mysql php-mysqli

fi

if [ "$IMAGEM_APP_PACOTESQLSERVER_PRESENTE" == "true" ]; then

    # Instalação dos componentes de conexão do SQL Server
    curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo
    ACCEPT_EULA=Y yum install -y msodbcsql17
    yum install -y libtool-ltdl-devel libodbc1 unixODBC unixODBC-devel php-mssql php-pdo
    pecl channel-update pecl.php.net
    pecl install sqlsrv-5.10.1 pdo_sqlsrv-5.10.1
    printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php.d/20-sqlsrv.ini
    printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php.d/30-pdo_sqlsrv.ini

    # Ver issue #19
    mkdir /opt2
    mv /opt/microsoft /opt2
    ln -s /opt2/microsoft /opt/microsoft

fi

if [ "$IMAGEM_APP_PACOTEORACLE_PRESENTE" == "true" ]; then

    # ORACLE oci

    unzip instantclient-precomp-linux.leppc64.c64-19.3.0.0.0dbru.zip -d /opt/
    unzip instantclient-basic-aix.ppc64-19.23.0.0.0dbru.zip -d /opt/
    unzip instantclient-sdk-aix.ppc64-19.23.0.0.0dbru.zip -d /opt/
    unzip instantclient-sqlplus-aix.ppc64-19.23.0.0.0dbru.zip -d /opt/

    echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf
    ldconfig

    # Install Oracle extensions
    yum install -y php-devel php-pear systemtap-sdt-devel
    pecl channel-update pecl.php.net
    export PHP_DTRACE=yes && pecl install oci8-2.2.0 && unset PHP_DTRACE

    echo "extension=oci8.so" > /etc/php.d/oci8.ini

fi

if [ "$IMAGEM_APP_PACOTEPOSTGRES_PRESENTE" == "true" ]; then

   yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-ppc64le/pgdg-redhat-repo-latest.noarch.rpm
   yum install -y postgresql php-pgsql

fi

cd -