DESCRIPTION = "Recipe to extract bitstream"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "virtual/hdf"

PROVIDES = "virtual/bitstream"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

inherit check_xsct_enabled xsctbit deploy image-artifact-names

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj -hdf_type ${HDF_EXT}"

do_compile[noexec] = "1"

BITSTREAM_NAME ?= "download"
BITSTREAM_NAME:microblaze ?= "system"

BITSTREAM_BASE_NAME ?= "${BITSTREAM_NAME}-${MACHINE}${IMAGE_VERSION_SUFFIX}"

MMI_BASE_NAME ?= "${BITSTREAM_NAME}-${MACHINE}${IMAGE_VERSION_SUFFIX}"

SYSROOT_DIRS += "/boot/bitstream"

do_install() {

    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        install -d ${D}/boot/bitstream/
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${D}/boot/bitstream/${BITSTREAM_BASE_NAME}.bit
        ln -sf ${BITSTREAM_BASE_NAME}.bit ${D}/boot/bitstream/${BITSTREAM_NAME}-${MACHINE}.bit
    else
	install -d ${D}/boot/bitstream/
        touch ${D}/boot/bitstream/${BITSTREAM_NAME}-${MACHINE}.bit
    fi

    #Microblaze xsa files contain mmi file which is required to generate download.bit, bin, and mcs files.
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.mmi ]; then
        install -d ${D}/boot/bitstream/
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.mmi ${D}/boot/bitstream/${MMI_BASE_NAME}.mmi
        ln -sf ${MMI_BASE_NAME}.mmi ${D}/boot/bitstream/${BITSTREAM_NAME}-${MACHINE}.mmi
    fi
}

do_deploy() {
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${DEPLOYDIR}/${BITSTREAM_BASE_NAME}.bit
        ln -sf ${BITSTREAM_BASE_NAME}.bit ${DEPLOYDIR}/${BITSTREAM_NAME}-${MACHINE}.bit
    else
        touch ${DEPLOYDIR}/${BITSTREAM_NAME}-${MACHINE}.bit
    fi

    #Microblaze xsa files contain mmi file which is required to generate download.bit, bin, and mcs files.
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.mmi ]; then
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.mmi ${DEPLOYDIR}/${MMI_BASE_NAME}.mmi
        ln -sf ${MMI_BASE_NAME}.mmi ${DEPLOYDIR}/${BITSTREAM_NAME}-${MACHINE}.mmi
    fi

}
addtask do_deploy after do_install

FILES:${PN} += "/boot/bitstream/*.bit /boot/bitstream/*.mmi"
