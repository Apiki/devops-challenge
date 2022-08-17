#!/bin/sh

set -e

echo 'waiting mysql connection...'
sleep 10s

while getopts t:u:p:e: flag
do
    case "${flag}" in
        t) title=${OPTARG};;
        u) user=${OPTARG};;
        p) password=${OPTARG};;
        e) email=${OPTARG};;
    esac
done

curl 'http://localhost:8080/wp-admin/install.php?step=2' -X POST \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-raw "weblog_title=${title}&user_name=${user}&admin_password=${password}&admin_password2=${password}&pw_weak=on&admin_email=${email}&blog_public=0" \
  --silent
