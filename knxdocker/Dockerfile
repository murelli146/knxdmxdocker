FROM debian:latest as builder

ARG BUILD_BRANCH
RUN echo BUILD_BRANCH: ${BUILD_BRANCH}

ENV BUILD_PACKAGES \
  autoconf \
  automake \
  autotools-dev \
  build-essential \
  cmake \
  debhelper \
  dh-systemd \
  git-core \
  libev-dev \
  libsystemd-dev \
  libtool \
  libusb-1.0-0-dev \
  pkg-config

RUN apt-get update && apt-get -y install $BUILD_PACKAGES

# build knxd

RUN git clone https://github.com/knxd/knxd.git && cd knxd && git checkout ${BUILD_BRANCH} \
  && dpkg-buildpackage -b -uc

# install in a fresh and thus clean environment

FROM debian:latest

COPY --from=builder /knxd_*.deb /knxd-tools_*.deb ./
RUN apt-get update && apt-get -y install libev4 libusb-1.0-0 init-system-helpers \
  && dpkg -i knxd_*.deb knxd-tools_*.deb

COPY root / 

EXPOSE 3672 6720

ENTRYPOINT ["sh","/etc/knxd/run.sh"]
