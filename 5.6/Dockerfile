FROM alpine:3.6

LABEL maintainer "https://github.com/blacktop"

ENV VERSION 5.6.3
ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/kibana"
ENV TARBAL "${DOWNLOAD_URL}/kibana-${VERSION}-linux-x86_64.tar.gz"
ENV TARBALL_ASC "${DOWNLOAD_URL}/kibana-${VERSION}-linux-x86_64.tar.gz.asc"
ENV TARBALL_SHA "fe957f0a2def9fb40be32ac77986d5eb7cc3373f828eed8eae074770ef965cf01c36028f2f9790f927e217ee59a283e63273eb768b9d2375aa0cdf15e4963c9a"
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
