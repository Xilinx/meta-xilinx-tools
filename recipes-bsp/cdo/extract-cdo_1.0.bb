DESCRIPTION = "Recipe to copy external cdos"

LICENSE = "CLOSED"

PROVIDES = "virtual/cdo"

DEPENDS += "virtual/hdf"

inherit xsctbase deploy

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI_append = " file://bitstream.tcl"

XSCTH_SCRIPT = "${WORKDIR}/bitstream.tcl"

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj -hdf_type ${HDF_EXT}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_versal = "versal"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

do_compile[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}/CDO
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/pmc_cdo.bin ${DEPLOYDIR}/CDO/
}
addtask do_deploy after do_install
