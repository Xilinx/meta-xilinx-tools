DESCRIPTION = "FS-BOOT generator"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

PROVIDES = "virtual/fsboot"

inherit xsctfsboot deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_microblaze = "microblaze"

S = "${WORKDIR}/git"
BRANCH = "master"
SRC_URI = "git://github.com/Xilinx/embeddedsw.git;protocol=https;branch=${BRANCH}"

SRCREV ?= "${AUTOREV}"

PV = "xilinx+git${SRCPV}"

XSCTH_APP = "mba_fs_boot"
do_install[noexec] = "1"

EXTRA_OEMAKE_BSP = ""
EXTRA_OEMAKE_APP = ""

do_compile() {
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_APP}_bsp ${EXTRA_OEMAKE_BSP} -j 1 && \
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ} ${EXTRA_OEMAKE_APP} -j 1
}

do_deploy() {
        install -d ${DEPLOYDIR}
        install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/executable.elf ${DEPLOYDIR}/fsboot-${MACHINE}.elf
}

addtask do_deploy after do_compile
