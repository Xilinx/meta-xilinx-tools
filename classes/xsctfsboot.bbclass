inherit xsctapp

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI_append =" \
  file://fsboot.tcl \
  file://base-hsi.tcl \
"

XSCTH_BUILD_CONFIG = ""

XSCTH_SCRIPT = "${WORKDIR}/fsboot.tcl"
