DESCRIPTION = "Pre Bootloader"

PROVIDES = "virtual/prefsbl"

inherit xsctapp xsctyaml deploy


COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_APP_zynqmp = "Zynq MP Pre-FSBL"
