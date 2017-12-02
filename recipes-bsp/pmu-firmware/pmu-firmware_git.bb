DESCRIPTION = "PMU Firmware"

PROVIDES = "virtual/pmu-firmware"

SRC_URI_append_zcu100-zynqmp = " file://0001-zcu100-poweroff-support.patch"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_COMPILER_DEBUG_FLAGS = "-O2 -DDEBUG_MODE -DENABLE_EM"
XSCTH_PROC_zynqmp = "psu_pmu_0"
XSCTH_APP  = "ZynqMP PMU Firmware"

INSANE_SKIP_${PN} = "arch"
INSANE_SKIP_${PN}-dbg = "arch"

do_deploy_append() {
    ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/pmu-${MACHINE}.elf
}
