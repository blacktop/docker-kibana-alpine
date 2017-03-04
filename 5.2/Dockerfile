FROM gliderlabs/alpine:3.4

MAINTAINER blacktop, https://github.com/blacktop

RUN apk-install openjdk8-jre tini su-exec

ENV KIBANA_VERSION 5.2.2

RUN apk-install bash nodejs
RUN apk-install -t .build-deps wget ca-certificates \
  && cd /tmp \
  && wget -O kibana-$KIBANA_VERSION.tar.gz https://artifacts.elastic.co/downloads/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz \
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
  && sed -i "s|$bundled|$apline_node|g" /usr/share/kibana/bin/kibana-plugin \
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
