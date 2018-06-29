inherit xsctbase

EMBEDDEDSW_REPO ??= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
EMBEDDEDSW_BRANCH ??= "release-2018.2"
EMBEDDEDSW_SRCREV ??= "6e82c0183bdfb9c6838966b9b87ef8385ba35504"


EMBEDDEDSW_BRANCHARG ?= "${@['nobranch=1', 'branch=${EMBEDDEDSW_BRANCH}'][d.getVar('EMBEDDEDSW_BRANCH', True) != '']}"
EMBEDDEDSW_SRCURI ?= "${EMBEDDEDSW_REPO};${EMBEDDEDSW_BRANCHARG}"
EMBEDDEDSW_PV ?= "${XILINX_VER_MAIN}+git${SRCPV}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=2a8d7a7f870f65ce77e8ccd8150cce10"

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

SYSROOT_DIRS += "/boot"

do_compile[lockfiles] = "${TMPDIR}/xsct-invoke.lock"
do_compile() {
    export RDI_PLATFORM=ln64
    export SWT_GTK3=0
    eval xsct ${XSCTH_SCRIPT} ${PROJ_ARG} -do_compile 1
    if [ ! -e ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ]; then
        bbfatal_log "${PN} compile failed."
    fi
}

do_install() {
	install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${D}/boot/${PN}.elf
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${DEPLOYDIR}/${XSCTH_BASE_NAME}.elf
    ln -sf ${XSCTH_BASE_NAME}.elf ${DEPLOYDIR}/${PN}-${MACHINE}.elf
}
addtask do_deploy after do_compile

FILES_${PN} = "/boot/${PN}.elf"
