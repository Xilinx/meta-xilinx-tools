DESCRIPTION = "FSBL"

PROVIDES = "virtual/fsbl"

inherit xsctapp xsctyaml deploy bootbin-component

BOOTBIN_BIF_FRAGMENT_zynqmp = "bootloader, destination_cpu=a53-0"
BOOTBIN_BIF_FRAGMENT_zynq = "bootloader"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_COMPILER_DEBUG_FLAGS = " -DFSBL_DEBUG_INFO"

XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"

XSCTH_MISC_append_zynqmpdr = " -lib libmetal"

