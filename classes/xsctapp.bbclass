inherit xsctbase

EMBEDDEDSW_REPO ?= "git://gitenterprise.xilinx.com/embeddedsw/embeddedsw.git;protocol=https"
EMBEDDEDSW_BRANCH ?= "2017.3_uspea"
EMBEDDEDSW_SRCREV ?= "16104bdca7bdc6ec943650d936b221e23e9bb94a"

EMBEDDEDSW_BRANCHARG ?= "${@['nobranch=1', 'branch=${EMBEDDEDSW_BRANCH}'][d.getVar('EMBEDDEDSW_BRANCH', True) != '']}"
EMBEDDEDSW_SRCURI ?= "${EMBEDDEDSW_REPO};${EMBEDDEDSW_BRANCHARG}"
EMBEDDEDSW_PV ?= "${XILINX_VER_MAIN}+git${SRCPV}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=eb37e98873aacb1943961642624b0447"

SRC_URI = "${EMBEDDEDSW_SRCURI}"
SRCREV = "${EMBEDDEDSW_SRCREV}"
PV = "${EMBEDDEDSW_PV}"
S = "${WORKDIR}/git"

XSCTH_BASE_NAME ?= "${PN}${PKGE}-${PKGV}-${PKGR}-${MACHINE}-${DATETIME}"
XSCTH_BASE_NAME[vardepsexclude] = "DATETIME"

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI_append = " file://app.tcl"
XSCTH_SCRIPT ?= "${WORKDIR}/app.tcl"

XSCTH_BUILD_DEBUG ?= "0"
XSCTH_BUILD_CONFIG ?= "${@['Debug', 'Release'][d.getVar('XSCTH_BUILD_DEBUG', True) == "0"]}"
XSCTH_EXECUTABLE ?= "${XSCTH_BUILD_CONFIG}/${XSCTH_PROJ}.elf"
XSCTH_APP_COMPILER_FLAGS ?= ""

do_install() {
	:
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${DEPLOYDIR}/${XSCTH_BASE_NAME}.elf
    ln -sf ${XSCTH_BASE_NAME}.elf ${DEPLOYDIR}/${PN}-${MACHINE}.elf
}
addtask do_deploy after do_compile
