SUMMARY = "Recipe to install update script"
DESCRIPTION = "Recipe to install update script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS_${PN} += "python3 python3-shell"

S = "${WORKDIR}"

SRC_URI = " \
	file://updateboot.py \
	"

#This variable is a list of the components to include in the bif file.
#it will be inserted into the updateboot.py script

BOOTBIN_BIF_ATTR_zynqmp = "fsbl bitstream-extraction pmu-firmware arm-trusted-firmware device-tree u-boot-xlnx"
BOOTBIN_BIF_ATTR_zynq = "fsbl bitstream-extraction u-boot-xlnx"
do_fetch[vardeps] += "BOOTBIN_BIF_ATTR"

BIF_FILE_PATH ?= "${B}/bootgen.bif"
BOOTGEN_EXTRA_ARGS ?= ""


#replace placeholder in script with elements to put in bif file
do_configure() {
    sed -i -e 's/@@BOOTBIN_BIF_ATTR@@/${BOOTBIN_BIF_ATTR}/' \
        "${WORKDIR}/updateboot.py"
}

do_install() {
    install -Dm 0755 ${WORKDIR}/updateboot.py ${D}${bindir}/updateboot
}
