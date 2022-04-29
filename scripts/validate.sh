#!/bin/sh

export FC_SETTINGS=/etc/krakend/config/settings/$ENVIRONMENT/$REGION
cp /etc/krakend/config/settings/common.json ${FC_SETTINGS}/common.json

/usr/bin/krakend check -c /etc/krakend/krakend.json
