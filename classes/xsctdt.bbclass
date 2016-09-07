inherit xsctbase

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI_append = " \
  file://dtgen.tcl \
  file://base-hsi.tcl \
"

XSCTH_SCRIPT = "${WORKDIR}/dtgen.tcl"
