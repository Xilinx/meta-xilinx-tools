DESCRIPTION = "FS-BOOT generator"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

PROVIDES = "virtual/fsboot"

inherit xsctfsboot deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_microblaze = "microblaze"

XSCTH_APP = "mba_fs_boot"

PARALLEL_MAKE = ""
EXTRA_OEMAKE_BSP = ""
EXTRA_OEMAKE_APP = ""

do_compile() {
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_APP}_bsp ${EXTRA_OEMAKE_BSP} -j 1 && \
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ} ${EXTRA_OEMAKE_APP} -j 1
}

do_deploy_append() {
        ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/fsboot-${MACHINE}.elf
}
