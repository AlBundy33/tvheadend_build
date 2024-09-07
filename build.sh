#!/bin/bash

if [ -z "$1" ]; then
  BASE=$(dirname "$0")
else
  BASE=$1
fi
(
  echo "start: `date`"
  if [ -d "$BASE/tvheadend" -a -d "$BASE/tvheadend/.git" ]; then
    cd "$BASE/tvheadend"
    git pull
  else
    cd "$BASE"
    git clone https://github.com/tvheadend/tvheadend.git tvheadend
    cd "$BASE/tvheadend"
  fi
  AUTOBUILD_CONFIGURE_EXTRA="--disable-libvpx_static --disable-bintray_cache --disable-ffmpeg_static --enable-libav --enable-libfdkaac --enable-hdhomerun_client" ./Autobuild.sh
  echo "end: `date` ($?)"
) 2>&1 | tee "$BASE/build.log"
