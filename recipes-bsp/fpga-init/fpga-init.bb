SUMMARY = "Set up wiring for fpgamanager init.d script"
DESCRIPTION = "Install init script and default config for fpgamanager which user can use to toggle init behavior"
LICENSE = "Proprietary"

LIC_FILES_CHKSUM = "file://${WORKDIR}/fpga-init.sh;md5=ade438cab0f6ec5e44391a3b27c7c25e"

inherit update-rc.d

INITSCRIPT_NAME = "fpga-init.sh"
INITSCRIPT_PARAMS = "start 03 S ."

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://fpga-init.sh \
    file://fpgamanager \
"
do_install() {
    install -Dm 0755 ${WORKDIR}/fpga-init.sh ${D}${sysconfdir}/init.d/fpga-init.sh
    install -Dm 0755 ${WORKDIR}/fpgamanager ${D}${sysconfdir}/default/fpgamanager
}

FILES_${PN} = "${sysconfdir}/init.d/fpga-init.sh ${sysconfdir}/default/fpgamanager"
