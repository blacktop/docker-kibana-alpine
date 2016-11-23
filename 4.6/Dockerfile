FROM gliderlabs/alpine:3.4

MAINTAINER blacktop, https://github.com/blacktop

ENV GOSU_VERSION 1.10
ENV GOSU_URL https://github.com/tianon/gosu/releases/download

# Install java and tini
RUN apk-install openjdk8-jre tini
# Install gosu
RUN apk-install -t build-deps wget ca-certificates gpgme \
  && set -x \
  && echo "Grab *gosu* for easy step-down from root..." \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
  && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true \
  && apk del --purge build-deps

ENV KIBANA_VERSION 4.6.3

RUN apk-install bash nodejs
RUN apk-install -t .build-deps wget ca-certificates \
  && cd /tmp \
  && wget -O kibana-$KIBANA_VERSION.tar.gz https://download.elastic.co/kibana/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
  && tar -xzf kibana-$KIBANA_VERSION.tar.gz \
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
  && sed -i "s|$bundled|$apline_node|g" /usr/share/kibana/bin/kibana \
  && rm -rf /usr/share/kibana/node \
  && chown -R kibana:kibana /usr/share/kibana \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

COPY docker-entrypoint.sh /

WORKDIR /usr/share/kibana
ENV PATH /usr/share/kibana/bin:$PATH

EXPOSE 5601
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
