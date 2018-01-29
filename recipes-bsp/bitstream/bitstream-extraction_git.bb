DESCRIPTION = "Recipe to extract bitstream"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "virtual/hdf"

PROVIDES = "virtual/bitstream"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

inherit xsctbit deploy

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj"

do_compile[noexec] = "1"

BITSTREAM_NAME ?= "download"
BITSTREAM_NAME_microblaze ?= "system"

BITSTREAM_BASE_NAME ?= "${BITSTREAM_NAME}-${MACHINE}-${DATETIME}"
BITSTREAM_BASE_NAME[vardepsexclude] = "DATETIME"

do_deploy() {
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${DEPLOYDIR}/${BITSTREAM_BASE_NAME}.bit
        ln -sf ${BITSTREAM_BASE_NAME}.bit ${DEPLOYDIR}/${BITSTREAM_NAME}-${MACHINE}.bit
    else
        touch ${DEPLOYDIR}/${BITSTREAM_NAME}-${MACHINE}.bit
    fi
}
addtask do_deploy after do_install
