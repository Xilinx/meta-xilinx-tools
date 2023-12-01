inherit xsctbase

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI:append = " file://bitstream.tcl"

XSCTH_SCRIPT = "${WORKDIR}/bitstream.tcl"
