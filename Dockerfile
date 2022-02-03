FROM alpine

# Installs latest Chromium (97) package.
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      yarn

# Prepare route-director
RUN wget https://github.com/osafi/route-director/archive/refs/heads/master.zip && \
    unzip master.zip && \
    mv route-director-master route-director &&\
    rm -rf master.zip && \
    cd route-director && \
    yarn install && \
    yarn build

# Configure chrome executable for puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

RUN yarn global add haxroomie-cli && \
    mkdir -p /root/.haxroomie/user-data-dir

COPY entrypoint.sh /
COPY config.js /root/.haxroomie/config.js

EXPOSE 8080
CMD ["/entrypoint.sh"]
HEALTHCHECK --interval=1m --timeout=2s --retries=20 CMD wget --no-verbose --tries=1 --spider 'http://localhost:3066' || exit 1