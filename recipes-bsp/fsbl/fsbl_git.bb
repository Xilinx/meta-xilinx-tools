DESCRIPTION = "FSBL"

PROVIDES = "virtual/fsbl"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_COMPILER_DEBUG_FLAGS = " -DFSBL_DEBUG_INFO"

XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"

XSCTH_MISC_append_zynqmpdr = " -lib libmetal"

