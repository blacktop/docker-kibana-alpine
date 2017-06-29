FROM alpine:3.6

LABEL maintainer "https://github.com/blacktop"

ENV KIBANA_VERSION 5.4.3

ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/kibana"
ENV TARBAL "${DOWNLOAD_URL}/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz"
ENV TARBALL_ASC "${DOWNLOAD_URL}/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz.asc"
ENV SHA1_URL "${DOWNLOAD_URL}/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz.sha1"
ENV GPG_KEY "46095ACC8548582C1A2699A9D27D666CD88E42B4"

ENV PATH /usr/share/kibana/bin:$PATH

RUN apk add --no-cache bash nodejs tini su-exec
RUN apk add --no-cache -t .build-deps wget ca-certificates gnupg openssl \
  && cd /tmp \
  && echo "===> Install Kibana..." \
  && EXPECTED_SHA=$(wget -O - ${SHA1_URL}) \
  && wget -O kibana.tar.gz "$TARBAL"; \
  if [ "$EXPECTED_SHA" ]; then \
    echo "$EXPECTED_SHA *kibana.tar.gz" | sha1sum -c -; \
  fi; \
  if [ "$TARBALL_ASC" ]; then \
    wget -O kibana.tar.gz.asc "$TARBALL_ASC"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY"; \
    gpg --batch --verify kibana.tar.gz.asc kibana.tar.gz; \
    rm -r "$GNUPGHOME" kibana.tar.gz.asc; \
  fi; \
  tar -xf kibana.tar.gz \
  && ls -lah \
  && mv kibana-$KIBANA_VERSION-linux-x86_64 /usr/share/kibana \
  && adduser -DH -s /sbin/nologin kibana \
  # the default "server.host" is "localhost" in 5+
  && sed -ri "s!^(\#\s*)?(server\.host:).*!\2 '0.0.0.0'!" /usr/share/kibana/config/kibana.yml \
  && grep -q "^server\.host: '0.0.0.0'\$" /usr/share/kibana/config/kibana.yml \
  # ensure the default configuration is useful when using --link
  && sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 'http://elasticsearch:9200'!" /usr/share/kibana/config/kibana.yml \
  && grep -q "^elasticsearch\.url: 'http://elasticsearch:9200'\$" /usr/share/kibana/config/kibana.yml \
  # usr alpine nodejs and not bundled version
  && bundled='NODE="${DIR}/node/bin/node"' \
  && apline_node='NODE="/usr/bin/node"' \
  && sed -i "s|$bundled|$apline_node|g" /usr/share/kibana/bin/kibana-plugin \
  && sed -i "s|$bundled|$apline_node|g" /usr/share/kibana/bin/kibana \
  && rm -rf /usr/share/kibana/node \
  && chown -R kibana:kibana /usr/share/kibana \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

COPY docker-entrypoint.sh /

WORKDIR /usr/share/kibana

EXPOSE 5601

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
