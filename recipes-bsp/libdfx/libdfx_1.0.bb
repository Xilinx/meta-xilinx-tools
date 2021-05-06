SUMMARY = "Xilinx libdfx library"
DESCRIPTION = "Xilinx libdfx Library and headers"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=94aba86aec117f003b958a52f019f1a7"

BRANCH ?= "master"
REPO ?= "git://github.com/Xilinx/libdfx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"
SRCREV = "6aec15214bf59ece3bb13b51d2d26dd899ba9389"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"
COMPATIBLE_MACHINE_versal = "versal"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} = "${PN}-staticdev"
PACKAGES =+ "${PN}-examples"

do_install () {
    install -d ${D}${libdir}
    install -d ${D}${includedir}
    install -d ${D}${bindir}
    install -m 0644 ${B}/src/libdfx.a ${D}${libdir}
    install -m 0644 ${B}/include/libdfx.h ${D}${includedir}
    install -m 0755 ${B}/apps/dfx_app ${D}${bindir}
}

ALLOW_EMPTY_${PN} = "1"
ALLOW_EMPTY_${PN}-examples = "1"
