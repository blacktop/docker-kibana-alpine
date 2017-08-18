![kibana-logo](https://raw.githubusercontent.com/blacktop/docker-kibana-alpine/master/kibana-logo.png)

docker-kibana-alpine
====================

[![CircleCI](https://circleci.com/gh/blacktop/docker-kibana-alpine.png?style=shield)](https://circleci.com/gh/blacktop/docker-kibana-alpine) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org) [![Docker Stars](https://img.shields.io/docker/stars/blacktop/kibana.svg)](https://hub.docker.com/r/blacktop/kibana/) [![Docker Pulls](https://img.shields.io/docker/pulls/blacktop/kibana.svg)](https://hub.docker.com/r/blacktop/kibana/) [![Docker Image](https://img.shields.io/badge/docker%20image-189MB-blue.svg)](https://hub.docker.com/r/blacktop/kibana/)

Alpine Linux based [Kibana](https://www.elastic.co/products/kibana) Docker Image

**Table of Contents**

-	[Why?](#why)
-	[Dependencies](#dependencies)
-	[Image Tags](#image-tags)
-	[Getting Started](#getting-started)
-	[Documentation](#documentation)
-	[Issues](#issues)
-	[Credits](#credits)
-	[CHANGELOG](#changelog)
-	[Contributing](#contributing)
-	[License](#license)

### Why?

Compare Image Sizes:  
 - official kibana = 679 MB - blacktop/kibana = 146 MB

**Alpine version is 145 MB smaller !**

### Dependencies

-	[alpine:3.6](https://index.docker.io/_/gliderlabs/alpine/)

### Image Tags

```bash
REPOSITORY          TAG                 SIZE
blacktop/kibana     latest              189MB
blacktop/kibana     6.0                 187MB
blacktop/kibana     5.5                 189MB
blacktop/kibana     5.4                 203MB
blacktop/kibana     5.3                 145MB
blacktop/kibana     x-pack              404MB
blacktop/kibana     5.2                 246MB
blacktop/kibana     5.1                 246MB
blacktop/kibana     5.0                 245.8MB
blacktop/kibana     4.6                 229.7MB
```

> **NOTE:** tag **x-pack** is the same as tag **latest**, but includes the *x-pack* plugin.

### Getting Started

```bash
$ docker run --init -d --name elastic -p 9200:9200 blacktop/elasticsearch
$ docker run --init -d --name kibana --link elastic:elasticsearch -p 5601:5601 blacktop/kibana
```

### Documentation

#### To use your own elasticsearch address via `ELASTICSEARCH_URL`

```bash
$ docker run --init -d --name kibana -e ELASTICSEARCH_URL=http://some-elasticsearch:9200 -p 5601:5601 blacktop/kibana
```

For elasticsearch running on a OSX host it would be

```bash
$ docker run --init -d --name kibana \
  -p 5601:5601 \
  --net host \
  -e ELASTICSEARCH_URL="http://$(ipconfig getifaddr en0):9200" \
  blacktop/kibana
```

=OR=

```bash
$ docker run --init -d --name kibana \
  -p 5601:5601 \
  --net host \
  -e ELASTICSEARCH_URL=http://localhost:9200 \
  blacktop/kibana
```

### Issues

Find a bug? Want more features? Find something missing in the documentation? Let me know! Please don't hesitate to [file an issue](https://github.com/blacktop/docker-kibana-alpine/issues/new)

### Credits

Heavily (if not entirely) influenced by https://github.com/docker-library/kibana

### CHANGELOG

See [`CHANGELOG.md`](https://github.com/blacktop/docker-kibana-alpine/blob/master/CHANGELOG.md)

### Contributing

[See all contributors on GitHub](https://github.com/blacktop/docker-kibana-alpine/graphs/contributors).

Please update the [CHANGELOG.md](https://github.com/blacktop/docker-kibana-alpine/blob/master/CHANGELOG.md) and submit a [Pull Request on GitHub](https://help.github.com/articles/using-pull-requests/).

### License

MIT Copyright (c) 2016-2017 **blacktop**
