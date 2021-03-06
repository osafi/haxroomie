FROM node:lts-stretch

RUN UBUNTU_FRONTEND=noninteractive \
  apt-get update && \
  apt-get -y install \
    git \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN yarn global add haxroomie-cli

RUN git clone https://github.com/osafi/route-director.git && \
    cd route-director && \
    yarn install && \
    yarn build

COPY entrypoint.sh healthcheck.sh /
COPY config.js /root/.haxroomie/config.js
EXPOSE 8080
CMD ["/entrypoint.sh"]
HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /healthcheck.sh || exit 1
