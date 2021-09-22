inherit systemd

SYSTEMD_SERVICE_${PN} = "sound.service"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/GPL-2.0-or-later;md5=fed54355545ffd980b814dab4a3b312c"

SRC_URI = "file://sound.service \
		   file://g12_sound.sh \
		   "


do_install_append() {
    install -d ${D}/${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/sound.service ${D}${systemd_system_unitdir}
    install -d ${D}/${bindir}
    install -m 0755 ${WORKDIR}/g12_sound.sh ${D}${bindir}
}

FILES_${PN} += "${bindir}/g12_sound.sh"
