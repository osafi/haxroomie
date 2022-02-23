#!/bin/sh

rm -f /tmp/haxroomie.lock
if [ ! -z "$HAXROOMIE_CONFIG" ]; then
  echo "$HAXROOMIE_CONFIG" > /root/.haxroomie/config.js
fi

yarn --cwd /route-director start &

haxroomie-cli --no-sandbox --disable-web-security --timeout=120 \
  `# setup paths to use /tmp - making it easier to run with tmpfs (e.g. "--mount type=tmpfs,destination=/tmp,tmpfs-mode=1777,tmpfs-size=256000000")` \
  --user-data-dir=/tmp/user-data \
  --chromium-args="--data-path=/tmp/data-path" \
  --chromium-args="--homedir=/tmp" \
  --chromium-args="--disk-cache-dir=/tmp/cache-dir" \
  `# various other chrome config options - mostly disabling unnecessary things - TODO: review these options` \
  --chromium-args="--disable-dev-shm-usage" \
  --chromium-args="--renderer-process-limit=64" \
  --chromium-args="--enable-low-res-tiling" \
  --chromium-args="--enable-native-gpu-memory-buffers" \
  --chromium-args="--webrtc-max-cpu-consumption-percentage=100" \
  --chromium-args="--disable-webrtc-encryption" \
  --chromium-args="--unlimited-storage" \
  --chromium-args='--disable-infobars' \
  --chromium-args='--single-process' \
  --chromium-args='--no-zygote' \
  --chromium-args='--no-first-run' \
  --chromium-args='--ignore-certificate-errors' \
  --chromium-args='--ignore-certificate-errors-skip-list' \
  --chromium-args='--disable-dev-shm-usage' \
  --chromium-args='--disable-accelerated-2d-canvas' \
  --chromium-args='--disable-gpu' \
  --chromium-args='--hide-scrollbars' \
  --chromium-args='--disable-notifications' \
  --chromium-args='--disable-background-timer-throttling' \
  --chromium-args='--disable-backgrounding-occluded-windows' \
  --chromium-args='--disable-breakpad' \
  --chromium-args='--disable-component-extensions-with-background-pages' \
  --chromium-args='--disable-extensions' \
  --chromium-args='--disable-features=TranslateUI,BlinkGenPropertyTrees' \
  --chromium-args='--disable-ipc-flooding-protection' \
  --chromium-args='--disable-renderer-backgrounding' \
  --chromium-args='--enable-features=NetworkService,NetworkServiceInProcess' \
  --chromium-args='--force-color-profile=srgb' \
  --chromium-args='--metrics-recording-only' \
  --chromium-args='--mute-audio'
