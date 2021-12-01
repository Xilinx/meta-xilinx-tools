inherit xsctbase

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI:append = " \
  file://dtgen.tcl \
  file://base-hsi.tcl \
"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

XSCTH_SCRIPT = "${WORKDIR}/dtgen.tcl"
