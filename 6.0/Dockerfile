FROM alpine:3.6

LABEL maintainer "https://github.com/blacktop"

ENV VERSION 6.0.0-rc2
ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/kibana"
ENV TARBAL "${DOWNLOAD_URL}/kibana-${VERSION}-linux-x86_64.tar.gz"
ENV TARBALL_ASC "${DOWNLOAD_URL}/kibana-${VERSION}-linux-x86_64.tar.gz.asc"
ENV TARBALL_SHA "318cd48d9f7aced508f8bb5aebf59d8d0a97696a26ce748d7381883059ba4ced45f3ebcb833e0e1b39746b249b9cdbc3c9186988c4f74dbf5263a81b658663ce  kibana-6.0.0-rc2-linux-x86_64.tar.gz"
ENV GPG_KEY "46095ACC8548582C1A2699A9D27D666CD88E42B4"

ENV PATH /usr/share/kibana/bin:$PATH

RUN apk add --no-cache bash nodejs su-exec
RUN apk add --no-cache -t .build-deps wget ca-certificates gnupg openssl \
  && cd /tmp \
  && echo "===> Install Kibana..." \
  && wget --progress=bar:force -O kibana.tar.gz "$TARBAL"; \
  if [ "$TARBALL_SHA" ]; then \
    echo "$TARBALL_SHA *kibana.tar.gz" | sha512sum -c -; \
  fi; \
  if [ "$TARBALL_ASC" ]; then \
    wget --progress=bar:force -O kibana.tar.gz.asc "$TARBALL_ASC"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY"; \
    gpg --batch --verify kibana.tar.gz.asc kibana.tar.gz; \
    rm -r "$GNUPGHOME" kibana.tar.gz.asc; \
  fi; \
  tar -xf kibana.tar.gz \
  && ls -lah \
  && mv kibana-$VERSION-linux-x86_64 /usr/share/kibana \
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
