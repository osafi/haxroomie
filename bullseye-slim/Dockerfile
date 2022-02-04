FROM node:lts-bullseye-slim

RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 unzip --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

RUN yarn global add haxroomie-cli && \
    mkdir -p /root/.haxroomie/user-data-dir && \
    # setup route-director service
    wget https://github.com/osafi/route-director/archive/refs/heads/master.zip && \
    unzip master.zip && \
    rm -rf master.zip && \
    mv route-director-master route-director &&\
    cd route-director && \
    yarn install && \
    yarn build

COPY entrypoint.sh /
COPY config.js /root/.haxroomie/config.js

EXPOSE 8080
CMD ["/entrypoint.sh"]
HEALTHCHECK --interval=1m --timeout=2s --retries=20 CMD wget --no-verbose --tries=1 --spider 'http://localhost:3066' || exit 1