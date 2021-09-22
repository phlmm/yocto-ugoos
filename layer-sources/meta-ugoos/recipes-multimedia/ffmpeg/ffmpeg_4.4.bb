include ffmpeg.inc 
#
#SRC_URI = "git://github.com/ffmpeg/ffmpeg.git;protocol=https;branch=master"
#SRCREV = "${AUTOREV}"
SRC_URI = "http://ffmpeg.org/releases/${BP}.tar.xz"
SRC_URI[sha256sum] = "06b10a183ce5371f915c6bb15b7b1fffbe046e8275099c96affc29e17645d909"

PACKAGECONFIG[dav1d] = "--enable-libdav1d,--disable-libdav1d,dav1d"

PACKAGECONFIG_append_ugoos-am6 = "gpl vidstab x265 x264 ${KODIFFMPEGADDITIONALS}"
