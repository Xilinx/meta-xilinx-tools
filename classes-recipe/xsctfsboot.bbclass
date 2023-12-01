inherit xsctapp

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI:append =" \
  file://fsboot.tcl \
  file://base-hsi.tcl \
"

XSCTH_BUILD_CONFIG = ""

XSCTH_SCRIPT = "${WORKDIR}/fsboot.tcl"
