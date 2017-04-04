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
