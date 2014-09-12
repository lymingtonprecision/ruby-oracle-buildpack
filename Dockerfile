FROM ubuntu:14.04
MAINTAINER Adam Harper <aharper@lymingtonprecision.co.uk>

ADD ./build/ /build
RUN \
  LC_ALL=C DEBIAN_FRONTEND=noninteractive bash /build/bin/prepare && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean && \
  rm -rf /build/resources

ENV PORT 5000

ONBUILD ADD . /src
ONBUILD RUN bash /build/bin/compile
