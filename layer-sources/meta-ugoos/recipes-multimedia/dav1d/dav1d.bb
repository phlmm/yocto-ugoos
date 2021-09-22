SUMMARY = "dav1d is the fastest AV1 decoder on all platforms :)"
HOMEPAGE = "https://code.videolan.org/videolan/dav1d"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=c8055cfe7548dfdaa3a6dc45d8793669"


SRCREV = "f951165ea6530c1bb589064709fe7ae7b7e9eb72"
SRC_URI = "git://code.videolan.org/videolan/dav1d.git;protocol=https"

S = "${WORKDIR}/git"

inherit meson lib_package

