DESCRIPTION = "FSBL"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=d19cfdb99d9e373dc66709f39fc861fd"

PROVIDES = "virtual/fsbl"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

YAML_COMPILER_FLAGS_append_zcu102-zynqmp = " -DXPS_BOARD_ZCU102"
YAML_COMPILER_FLAGS_append_zcu106-zynqmp = " -DXPS_BOARD_ZCU106"
XSCTH_COMPILER_DEBUG_FLAGS = "-O2 -DFSBL_DEBUG_INFO"

XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"
