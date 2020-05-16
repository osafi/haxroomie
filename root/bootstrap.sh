#!/bin/bash

rm -f /tmp/haxroomie.lock
mkdir -p /root/.haxroomie
if [ ! -f /root/.haxroomie/config.js ]; then
  echo "$HAXROOMIE_CONFIG" > /root/.haxroomie/config.js
fi

haxroomie-cli --no-sandbox
