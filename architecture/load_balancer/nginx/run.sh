#!/bin/bash

cd /etc/nginx
nginx &

service fail2ban stop
service fail2ban start

tail -f /var/log/fail2ban.log

