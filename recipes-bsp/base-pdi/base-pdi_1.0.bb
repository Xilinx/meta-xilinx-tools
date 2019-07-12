DESCRIPTION = "Recipe to deploy base pdi"

LICENSE = "CLOSED"

PROVIDES = "virtual/base-pdi"

DEPENDS += "virtual/hdf unzip-native"

HDF_EXT ?= "dsa"
PDI_HDF ?= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.${HDF_EXT}"

do_configure[depends] += "virtual/hdf:do_deploy"

B = "${WORKDIR}/build"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_versal = "versal"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

do_compile[noexec] = "1"

do_configure() {
    cp -f ${PDI_HDF} ${B}
    unzip ${B}/`basename ${PDI_HDF}` -d ${B}
}

do_install() {
    install -d ${D}/boot
    install -m 0644 $(ls ${B}/*.pdi | head -1)  ${D}/boot/base-design.pdi
}
SYSROOT_DIRS += "/boot"

FILES_${PN} += "/boot/*"
