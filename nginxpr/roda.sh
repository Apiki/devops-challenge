#!/bin/bash

service cron start
nginx -g 'daemon off;'
##nginx -s reload



