KODIURI ?= "git://github.com/xbmc/xbmc.git;protocol=https;branch=matrix"
#KODIREV ?= "${KODIVER}-${KODICODENAME}"
KODIWORKDIR ?= "${WORKDIR}/git"

KODIPATCHES ?= ""
KODIADDONS ?= ""

SRC_URI = "${KODIURI}"
SRCREV = "${AUTOREV}"
#SRCREV = "b8bed8e8618ba585f598d22454fb543060d2e1ee"
S = "${KODIWORKDIR}"


LICENSE = "GPLv2"
LIC_FILES_CHKSUM ?= "file:///${WORKDIR}/git/LICENSE.md;md5=7b423f1c9388eae123332e372451a4f7"
PACKAGECONFIG_append_ugoos-am6 = "gbm systemd bluetooth pulseaudio"
PACKAGECONFIG_remove_ugoos-am6 = "vaapi vdpau xa "

EXTRA_OECMAKE_ugoos_am6 += "--enable-cross-compile"
#DEPENDS_remove_ugoos-am6 = "virtual/egl"

DEPENDS_ugoos-am6 += "gnutls dav1d ccache-native mdns \
  virtual/egl \
  harfbuzz \
  curl-native \
  flatbuffers-native \
  googletest-native \
  gperf-native \
  kodi-tools-jsonschemabuilder-native \
  kodi-tools-texturepacker-native \
  nasm-native \
  swig-native \
  unzip-native \
  yasm-native \
  zip-native \
  avahi \
  boost \
  bzip2 \
  crossguid \
  curl \
  dcadec \
  enca \
  expat \
  faad2 \
  ffmpeg \
  flatbuffers \
  fmt \
  fontconfig \
  fribidi \
  fstrcmp \
  giflib \
  libass \
  libcdio \
  libcec \
  libdvdcss \
  libdvdnav \
  libdvdread \
  libinput \
  libmad \
  libmicrohttpd \
  libmms \
  libmodplug \
  libnfs \
  libpcre \
  libplist \
  libsamplerate0 \
  libsquish \
  libssh \
  libtinyxml \
  libusb1 \
  libxkbcommon \
  libxslt \
  lzo \
  mpeg2dec \
  python3 \
  rapidjson \
  spdlog \
  sqlite3 \
  taglib \
  udev \
  wavpack \
  yajl \
  zlib \
"
