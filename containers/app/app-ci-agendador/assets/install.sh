#!/bin/bash

set -e

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py

python3 get-pip.py


#Instalação Supervisor
pip install "supervisor>=4"
mkdir -p /etc/supervisor/
#echo_supervisord_conf > /etc/supervisor/supervisord.conf
mv /tmp/assets/conf/supervisord.conf /etc/supervisor/supervisord.conf
mv /tmp/assets/conf/mod-pen/supervisor.ini.template /etc/supervisor/
mv /tmp/assets/scripts-e-automatizadores/entrypoint-agendador.sh /
chmod +x /entrypoint-agendador.sh


yum clean all
rm -rf /var/cache/yum
