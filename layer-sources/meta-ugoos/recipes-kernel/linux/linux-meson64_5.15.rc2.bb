#
# Linux Support for 64bit Amlogic Meson SoCs
#
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV = "${AUTOREV}"
BRANCH = "master"
URI_STABLE="git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
URI_MASTER="git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/"
URI="${URI_MASTER}"
PROTOCOL="https"


DEPENDS += "rsync-native"

LINUX_VERSION = "5.15-rc2"
	
# Linux stable tree
SRC_URI_ugoos-am6 = "git://${URI};protocol=${PROTOCOL};branch=${BRANCH} \
			file://amlogic-0001-HACK-set-meson-gx-cma-pool-to-896MB.patch \
			file://amlogic-0002-HACK-set-meson-g12-cma-pool-to-896MB.patch \
			file://amlogic-0003-HACK-arm64-fix-Kodi-sysinfo-CPU-information.patch \
			file://defconfig \
"

KERNEL_VERSION_SANITY_SKIP="1"

KERNEL_CLASSES = "kernel-uimage-meson"

LINUX_VERSION_EXTENSION_append = "-meson64"

KERNEL_CONFIG_COMMAND ?= "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

require recipes-kernel/linux/linux-meson.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
