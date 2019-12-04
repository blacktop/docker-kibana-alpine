FROM node:10.15.2-alpine

LABEL maintainer "https://github.com/blacktop"

ENV VERSION 7.5.0
ENV DOWNLOAD_URL https://artifacts.elastic.co/downloads/kibana
ENV TARBAL "${DOWNLOAD_URL}/kibana-oss-${VERSION}-linux-x86_64.tar.gz"
ENV TARBALL_ASC "${DOWNLOAD_URL}/kibana-oss-${VERSION}-linux-x86_64.tar.gz.asc"
ENV TARBALL_SHA "42ff9f73badf9f4fdf8a99fe87ec742ac256742ae99eb0b7147e6fb30f9b34b11ec25579d5bab73a9765109db304735a524526d4d629de5d0e10f2aff9f4c930"
ENV GPG_KEY "46095ACC8548582C1A2699A9D27D666CD88E42B4"

ENV PATH /usr/share/kibana/bin:$PATH

RUN apk add --no-cache bash su-exec
RUN apk add --no-cache -t .build-deps wget ca-certificates gnupg openssl \
  && set -ex \
  && cd /tmp \
  && echo "===> Install Kibana..." \
  && wget --progress=bar:force -O kibana.tar.gz "$TARBAL"; \
  if [ "$TARBALL_SHA" ]; then \
  echo "$TARBALL_SHA *kibana.tar.gz" | sha512sum -c -; \
  fi; \
  if [ "$TARBALL_ASC" ]; then \
  wget --progress=bar:force -O kibana.tar.gz.asc "$TARBALL_ASC"; \
  export GNUPGHOME="$(mktemp -d)"; \
  ( gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
  || gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEY" \
  || gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEY" ); \
  gpg --batch --verify kibana.tar.gz.asc kibana.tar.gz; \
  rm -rf "$GNUPGHOME" kibana.tar.gz.asc || true; \
  fi; \
  tar -xf kibana.tar.gz \
  && ls -lah \
  && mv kibana-$VERSION-linux-x86_64 /usr/share/kibana \
  && adduser -DH -s /sbin/nologin kibana \
  # usr alpine nodejs and not bundled version
  && bundled='NODE="${DIR}/node/bin/node"' \
  && alpine_node='NODE="/usr/local/bin/node"' \
  && sed -i "s|$bundled|$alpine_node|g" /usr/share/kibana/bin/kibana-plugin \
  && sed -i "s|$bundled|$alpine_node|g" /usr/share/kibana/bin/kibana \
  && rm -rf /usr/share/kibana/node \
  && chown -R kibana:kibana /usr/share/kibana \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

COPY config/kibana/kibana.yml /usr/share/kibana/config/kibana.yml
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

WORKDIR /usr/share/kibana

EXPOSE 5601

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
