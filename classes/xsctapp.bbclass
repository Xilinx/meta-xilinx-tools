inherit xsctbase

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}:"
SRC_URI_append = " file://app.tcl"

XSCTH_SCRIPT = "${WORKDIR}/app.tcl"
