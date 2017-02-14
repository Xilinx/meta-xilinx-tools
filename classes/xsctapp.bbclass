inherit xsctbase

EMBEDDEDSW_REPO ?= "git://gitenterprise.xilinx.com/embeddedsw/embeddedsw.git"
EMBEDDEDSW_BRANCH ?= ""
EMBEDDEDSW_SRCREV ?= "b9ff975d9f8684a581e3aebcf94319a0bb9e9d1b"

EMBEDDEDSW_BRANCHARG ?= "${@['nobranch=1', 'branch=${EMBEDDEDSW_BRANCH}'][d.getVar('EMBEDDEDSW_BRANCH', True) != '']}"
EMBEDDEDSW_SRCURI ?= "${EMBEDDEDSW_REPO};protocol=https;${EMBEDDEDSW_BRANCHARG}"
EMBEDDEDSW_PV ?= "${XILINX_VER_MAIN}+git${SRCPV}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

SRC_URI = "${EMBEDDEDSW_SRCURI}"
SRCREV = "${EMBEDDEDSW_SRCREV}"
PV = "${EMBEDDEDSW_PV}"
S = "${WORKDIR}/git"

XSCTH_BASE_NAME ?= "${PN}${PKGE}-${PKGV}-${PKGR}-${MACHINE}-${DATETIME}"
XSCTH_BASE_NAME[vardepsexclude] = "DATETIME"

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI_append = " file://app.tcl"
XSCTH_SCRIPT ?= "${WORKDIR}/app.tcl"

do_install[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/Release/${XSCTH_PROJ}.elf ${DEPLOYDIR}/${XSCTH_BASE_NAME}.elf
    ln -sf ${XSCTH_BASE_NAME}.elf ${DEPLOYDIR}/${PN}-${MACHINE}.elf
}
addtask do_deploy after do_compile
