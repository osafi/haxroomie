#!/bin/bash

rm -f /tmp/haxroomie.lock
if [ ! -z "$HAXROOMIE_CONFIG" ]; then
  echo "$HAXROOMIE_CONFIG" > /root/.haxroomie/config.js
fi

yarn --cwd /route-director start &

haxroomie-cli --no-sandbox --disable-web-security
