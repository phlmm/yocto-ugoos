SUMMARY = "Pre-Built Amlogic FIP Binaries distributed in U-Boot"
PROVIDES = "amlogic-fip"

LICENSE = "Proprietary"

COMPATIBLE_MACHINE_ugoos-am6 = "ugoos-am6"

SUBDIR_ugoos-am6 = "odroid-n2"

DEPLOY_CMD_ugoos-am6 = "do_deploy_g12b"

LIC_FILES_CHKSUM = "file://lepotato/blx_fix.sh;md5=12ad2eef4a1dcc98f9eda15224b92836"

SRC_URI_ugoos-am6 = "git://github.com/LibreELEC/amlogic-boot-fip.git"
SRCREV_ugoos-am6 = "ac20772f44b2b74c8f55331b5c91a277d0bfbc37"

S = "${WORKDIR}/git"

inherit deploy

do_compile () {
	:
}

PACKAGE_ARCH = "${MACHINE_ARCH}"


do_deploy_g12b () {
    mkdir -p ${DEPLOYDIR}/fip
    install ${S}/${SUBDIR}/bl2.bin ${DEPLOYDIR}/fip/bl2.bin
    install ${S}/${SUBDIR}/acs.bin ${DEPLOYDIR}/fip/acs.bin
    install ${S}/${SUBDIR}/bl30.bin ${DEPLOYDIR}/fip/bl30.bin
    install ${S}/${SUBDIR}/bl301.bin ${DEPLOYDIR}/fip/bl301.bin
    install ${S}/${SUBDIR}/bl31.img ${DEPLOYDIR}/fip/bl31.img
    install ${S}/${SUBDIR}/ddr3_1d.fw ${DEPLOYDIR}/fip/ddr3_1d.fw
    install ${S}/${SUBDIR}/ddr4_1d.fw ${DEPLOYDIR}/fip/ddr4_1d.fw
    install ${S}/${SUBDIR}/ddr4_2d.fw ${DEPLOYDIR}/fip/ddr4_2d.fw
    install ${S}/${SUBDIR}/diag_lpddr4.fw ${DEPLOYDIR}/fip/diag_lpddr4.fw
    [ -e "${S}/${SUBDIR}/lpddr3_1d.fw" ] && install ${S}/${SUBDIR}/lpddr3_1d.fw ${DEPLOYDIR}/fip/lpddr3_1d.fw
    install ${S}/${SUBDIR}/lpddr4_1d.fw ${DEPLOYDIR}/fip/lpddr4_1d.fw
    install ${S}/${SUBDIR}/lpddr4_2d.fw ${DEPLOYDIR}/fip/lpddr4_2d.fw
    install ${S}/${SUBDIR}/piei.fw ${DEPLOYDIR}/fip/piei.fw
    install ${S}/${SUBDIR}/aml_ddr.fw ${DEPLOYDIR}/fip/aml_ddr.fw
    install ${S}/${SUBDIR}/blx_fix.sh ${DEPLOYDIR}/fip/blx_fix.sh
    install ${S}/${SUBDIR}/acs_tool.py ${DEPLOYDIR}/fip/acs_tool.py
    install ${S}/${SUBDIR}/aml_encrypt_g12b ${DEPLOYDIR}/fip/aml_encrypt_g12b
}

do_deploy() {
    ${DEPLOY_CMD}
}

addtask deploy before do_build after do_compile
