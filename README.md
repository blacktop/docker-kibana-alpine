<img src="https://cdn.rawgit.com/blacktop/docker-kibana-alpine/master/kibana-logo.svg" alt="kibana-logo" width="200" height="200">

docker-kibana-alpine
====================

[![CircleCI](https://circleci.com/gh/blacktop/docker-kibana-alpine.png?style=shield)](https://circleci.com/gh/blacktop/docker-kibana-alpine) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org) [![Docker Stars](https://img.shields.io/docker/stars/blacktop/kibana.svg)](https://hub.docker.com/r/blacktop/kibana/) [![Docker Pulls](https://img.shields.io/docker/pulls/blacktop/kibana.svg)](https://hub.docker.com/r/blacktop/kibana/) [![Docker Image](https://img.shields.io/badge/docker image-288.4 MB-blue.svg)](https://hub.docker.com/r/blacktop/kibana/)

Alpine Linux based Elasticsearch Docker Image

**Table of Contents**

  - [Why?](#why)
  - [Dependencies](#dependencies)
  - [Image Tags](#image-tags)
  - [Getting Started](#getting-started)
  - [Documentation](#documentation)
  - [Issues](#issues)
  - [Credits](#credits)
  - [CHANGELOG](#changelog)
  - [Contributing](#contributing)
  - [License](#license)

### Why?

Compare Image Sizes:  
 - official kibana = 320.8 MB
 - blacktop/kibana = 288.4 MB

**Alpine version is 32.4 MB smaller !**  
> Ok that isn't that much smaller, but I have a version that comes with [X-Pack](https://www.elastic.co/guide/en/x-pack/current/xpack-introduction.html) built in! :wink:

### Dependencies

-	[gliderlabs/alpine:3.4](https://index.docker.io/_/gliderlabs/alpine/)

### Image Tags

```bash
REPOSITORY               TAG                 SIZE
blacktop/kibana          latest              288.4
blacktop/kibana          5.0                 288.4
blacktop/kibana          x-pack              147.5 MB
blacktop/kibana          4.6                 141.5 MB
```

> **NOTE:** tag **x-pack** is the same as tag **latest**, but includes the *x-pack* plugin.  

### Getting Started

```bash
$ docker run -d --name kibana -p 80:5601 blacktop/kibana
```

### Documentation

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

MIT Copyright (c) 2016 **blacktop**
