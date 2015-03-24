#!/bin/bash -e

mkdir -p /data/sympa/log
mkdir -p /data/sympa/etc/includes
mkdir -p /data/sympa/etc/shared
mkdir -p /data/sympa/spool
mkdir -p /data/sympa/nullmailer
mkdir -p /data/sympa/data

# /data/sympa/etc/includes/database contains a password for sympa user with
# permissions over sympa PostgreSQL database at pgsql.server2.docker
# /data/sympa/etc/includes/cookie contains crypto cookie string secret

# You can create the database with:
# createuser -h pgsql.server2.docker -PE -DRS -U postgres -W sympa
# createdb -h pgsql.server2.docker -U postgres -W -O sympa sympa

# You might have to initialize the database with:
# psql -h pgsql.server2.docker -U sympa -W -f /usr/share/sympa/bin/create_db.Pg

docker run -d --restart=always --name sympa --hostname sympa -e SET_REAL_IP_FROM=172.17.0.0/16 -v /data/var/hosts:/etc/hosts:ro -v /data/sympa/log:/var/log/sympa -v /data/sympa/etc/includes:/etc/sympa/includes -v /data/sympa/etc/shared:/etc/sympa/shared -v /data/sympa/spool:/var/spool/sympa -v /data/sympa/nullmailer:/var/spool/nullmailer -v /data/sympa/data:/var/lib/sympa nasqueron/sympa
