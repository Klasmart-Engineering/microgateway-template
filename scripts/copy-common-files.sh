#!/bin/sh

# Intended to be run within Dockerfile
find /etc/krakend/config/settings -type d -exec cp /etc/krakend/config/settings/common.json {} \;