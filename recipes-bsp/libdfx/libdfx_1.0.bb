SUMMARY = "Xilinx libdfx library"
DESCRIPTION = "Xilinx libdfx Library and headers"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=ff47f40fa4b99629a63b3e2606a20171"

BRANCH ?= "master"
REPO ?= "git://github.com/Xilinx/libdfx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"
SRCREV ?= "c18bc05505546a6f1a768c25909588abd699c5ea"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"
COMPATIBLE_MACHINE_versal = "versal"

S = "${WORKDIR}/git/"

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
