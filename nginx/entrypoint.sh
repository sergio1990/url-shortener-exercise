#!/bin/bash

set -e

CONFIG_TEMPLATE_PATH="/tmp/nginx.conf.prod.tmpl"

if [ "$1" == "run-dev" ]; then
  CONFIG_TEMPLATE_PATH="/tmp/nginx.conf.dev.tmpl"
fi

sed \
  -e "s/{{SERVER_NAME}}/$SERVER_NAME/g" \
  -e "s/{{API_HOST}}/$API_HOST/g" \
  -e "s/{{ADMIN_HOST}}/$ADMIN_HOST/g" \
  $CONFIG_TEMPLATE_PATH > /etc/nginx/nginx.conf

nginx -c /etc/nginx/nginx.conf -g "daemon off;"
