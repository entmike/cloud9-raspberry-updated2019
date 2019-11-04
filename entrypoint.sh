#!/bin/sh
if [ ! -z $AUTH ]; then
  AUTH="--auth $AUTH"
fi

if [ ! -z $COLLAB ]; then
  COLLAB="--collab"
fi

if [ -e /var/run/docker.sock ]; then chown cloud9ide:docker /var/run/docker.sock; fi
runuser -l cloud9ide -c '/home/cloud9ide/.c9/node/bin/node /home/cloud9ide/cloud9/server.js $AUTH $COLLAB --listen 0.0.0.0 --port 8080 -w /workspace'
