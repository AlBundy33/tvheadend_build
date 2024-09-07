FROM debian:bookworm as base

RUN apt update && apt upgrade
RUN apt --yes --no-install-recommends install apt-transport-https ca-certificates \
 && update-ca-certificates
RUN apt --yes --no-install-recommends install build-essential git pkg-config libssl-dev bzip2 wget fakeroot
RUN apt --yes --no-install-recommends install libavahi-client-dev zlib1g-dev libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavfilter-dev
RUN apt --yes --no-install-recommends install debhelper liburiparser-dev python-is-python3 python3 cmake libpcre2-dev python3-requests libdvbcsa-dev ffmpeg libx264-dev libx265-dev libvpx-dev libopus-dev

FROM base as builder
ARG AUTOBUILD_CONFIGURE_EXTRA=
COPY --chmod=0744 build.sh /
RUN mkdir -p /build
WORKDIR /build
VOLUME /build
VOLUME /tmp

USER 1000
CMD ["/build.sh", "/build"]
