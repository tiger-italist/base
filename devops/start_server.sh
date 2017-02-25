#!/bin/bash

set -e

sudo chmod 1777 /tmp

APP_FOLDER="/italist_api"
cd $APP_FOLDER

sudo /etc/init.d/nginx start

#newrelic-admin generate-config $NEW_RELIC_APP_KEY newrelic.ini
#export NEW_RELIC_CONFIG_FILE=newrelic.ini

#newrelic-admin

uwsgi \
    --callable app \
    --gevent 100 \
    --processes 4 \
    --socket 127.0.0.1:8080 \
    --stats 127.0.0.1:9191 \
    --threads 2 \
    --wsgi-file italist_api.py
