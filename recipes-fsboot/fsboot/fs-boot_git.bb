DESCRIPTION = "FS-BOOT generator"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

PROVIDES = "virtual/fsboot"

inherit xsctfsboot deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_microblaze = "microblaze"

S = "${WORKDIR}/git"

# Sources, by default allow for the use of SRCREV pointing to orphaned tags/commits
ESWBRANCH ?= ""
SRCBRANCHARG = "${@['nobranch=1', 'branch=${ESWBRANCH}'][d.getVar('ESWBRANCH', True) != '']}"

SRC_URI = "git://github.com/Xilinx/embeddedsw.git;protocol=https;${SRCBRANCHARG}"

# This points to xilinx-v2016.4 tag
SRCREV ?= "a931a8d4471ad6d1e1ecdfd41f1da66d98d6f137"
PV = "xilinx+git${SRCPV}"

XSCTH_APP = "mba_fs_boot"
do_install[noexec] = "1"

PARALLEL_MAKE = ""
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
