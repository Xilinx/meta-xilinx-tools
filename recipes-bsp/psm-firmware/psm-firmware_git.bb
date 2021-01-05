DESCRIPTION = "PSM Firmware"
SUMMARY = "PSM firmware for versal devices"

PROVIDES = "virtual/psm-firmware"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_versal = "versal"

XSCTH_PROC_IP_versal = "psv_psm"
XSCTH_APP   = "versal PSM Firmware"

INSANE_SKIP_${PN} = "arch"
INSANE_SKIP_${PN}-dbg = "arch"

