DESCRIPTION = "FSBL"

PROVIDES = "virtual/fsbl"

inherit xsctapp xsctyaml deploy

SRC_URI_append_zcu100-zynqmp = " file://0001-zcu100-poweroff-support.patch"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_APP_COMPILER_FLAGS_append_zcu102-zynqmp = " -DXPS_BOARD_ZCU102"
XSCTH_APP_COMPILER_FLAGS_append_zcu106-zynqmp = " -DXPS_BOARD_ZCU106"
XSCTH_COMPILER_DEBUG_FLAGS = "-O2 -DFSBL_DEBUG_INFO"

XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"

STAGING_RFDC_DIR = "${TMPDIR}/work-shared/${MACHINE}/rfdc-source"

addtask shared_workdir after do_compile before do_install
do_shared_workdir() {
    install -d ${STAGING_RFDC_DIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_bsp/${XSCTH_PROC}/libsrc/rfdc*/src/xrfdc_g.c ${STAGING_RFDC_DIR}
}

addtask shared_workdir_setscene
do_shared_workdir_setscene () {
     exit 1
}

do_install() {
    install -d ${D}${includedir}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_bsp/${XSCTH_PROC}/include/xparameters.h ${D}${includedir}/xparameters.h
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_bsp/${XSCTH_PROC}/libsrc/standalone*/src/xparameters_ps.h ${D}${includedir}/xparameters_ps.h
}

