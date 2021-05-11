inherit xsctbase

REPO ??= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ??= "release-2020.2.2_k26"
SRCREV ??= "6d507ed8c006d8090aec8c10e24ef34706920884"


EMBEDDEDSW_BRANCHARG ?= "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
EMBEDDEDSW_SRCURI ?= "${REPO};${EMBEDDEDSW_BRANCHARG}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://license.txt;md5=64e026e5fcf32dffb500cb265cf57fe1"

SRC_URI = "${EMBEDDEDSW_SRCURI}"
PV = "${XILINX_VER_MAIN}+git${SRCPV}"
S = "${WORKDIR}/git"

XSCTH_BASE_NAME ?= "${PN}${PKGE}-${PKGV}-${PKGR}-${MACHINE}-${DATETIME}"
XSCTH_BASE_NAME[vardepsexclude] = "DATETIME"

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI_append = " file://app.tcl"
XSCTH_SCRIPT ?= "${WORKDIR}/app.tcl"

XSCTH_BUILD_DEBUG ?= "0"
XSCTH_BUILD_CONFIG ?= "${@['Debug', 'Release'][d.getVar('XSCTH_BUILD_DEBUG') == "0"]}"
XSCTH_APP_COMPILER_FLAGS ?= ""

SYSROOT_DIRS += "/boot"

do_compile[lockfiles] = "${TMPDIR}/xsct-invoke.lock"
do_compile() {

    cd ${B}/${XSCTH_PROJ}
    make
    if [ ! -e ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ]; then
        bbfatal_log "${XSCTH_PROJ} compile failed."
    fi
}

do_install() {
    install -Dm 0644 ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${D}/boot/${PN}-${SRCPV}.elf
}

do_deploy() {
    install -Dm 0644 ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${DEPLOYDIR}/${XSCTH_BASE_NAME}.elf
    ln -sf ${XSCTH_BASE_NAME}.elf ${DEPLOYDIR}/${PN}-${MACHINE}.elf
}
addtask do_deploy after do_compile

FILES_${PN} = "/boot/${PN}-${SRCPV}.elf"
