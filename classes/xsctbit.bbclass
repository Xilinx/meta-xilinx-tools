inherit xsctbase

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI_append = " file://bitstream.tcl"

XSCTH_SCRIPT = "${WORKDIR}/bitstream.tcl"
