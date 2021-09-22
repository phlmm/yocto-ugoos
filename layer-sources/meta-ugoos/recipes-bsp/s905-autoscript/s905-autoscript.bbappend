LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "u-boot-mkimage-native"

FILESEXTRAPATHS_prepend_ugoos-am6 := "${THISDIR}/files:"
SRC_URI_ugoos-am6 = "file://ugoos_autoscript.cmd"


inherit deploy

S = "${WORKDIR}"

do_compile() {
	mkimage -A arm64 -O linux -T script -C none -a 0 -e 0 -n "s905_autoscript" -d ${WORKDIR}/ugoos_autoscript.cmd ${B}/s905_autoscript
}

do_deploy() {
	install ${B}/s905_autoscript ${DEPLOYDIR}/s905_autoscript
}

addtask deploy before do_build after do_compile

