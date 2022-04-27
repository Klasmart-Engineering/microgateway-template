#!/bin/sh

export FC_SETTINGS=/etc/krakend/config/settings/$ENVIRONMENT/$REGION

/usr/bin/krakend check -c /etc/krakend/krakend.json
