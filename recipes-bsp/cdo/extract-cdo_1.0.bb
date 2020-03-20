DESCRIPTION = "Recipe to copy external cdos"

LICENSE = "CLOSED"

inherit deploy

PROVIDES = "virtual/cdo"

DEPENDS += "virtual/boot-bin bootgen-native"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_versal = "versal"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

B = "${WORKDIR}/build"

BOOTGEN_CMD ?= "bootgen"
BOOTGEN_ARGS ?= "-arch versal"
BOOTGEN_OUTFILE ?= "BOOT.bin"

do_compile() {

    cp ${RECIPE_SYSROOT}/boot/BOOT.bin ${B}
    ${BOOTGEN_CMD} ${BOOTGEN_ARGS} -dump ${BOOTGEN_OUTFILE} pmc_cdo
}

do_deploy() {
    install -d ${DEPLOYDIR}/CDO
    install -m 0644 ${B}/pmc_cdo.bin* ${DEPLOYDIR}/CDO/pmc_cdo.bin
}
addtask do_deploy after do_install
