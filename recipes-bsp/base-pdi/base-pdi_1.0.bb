DESCRIPTION = "Recipe to deploy base pdi"

LICENSE = "CLOSED"

PROVIDES = "virtual/base-pdi"

DEPENDS += "virtual/hdf"

HDF_EXT ?= "xsa"
PDI_HDF ?= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.${HDF_EXT}"

inherit xsctbit

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj -hdf_type ${HDF_EXT}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_versal = "versal"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

do_compile[noexec] = "1"

do_install() {
    install -d ${D}/boot
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.pdi ${D}/boot/base-design.pdi
}
SYSROOT_DIRS += "/boot"

FILES_${PN} += "/boot/*"
