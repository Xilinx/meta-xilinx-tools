DESCRIPTION = "PMU Firmware"

PROVIDES = "virtual/pmu-firmware"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

YAML_COMPILER_FLAGS_append_zcu100-zynqmp ?= " -DPMU_MIO_INPUT_PIN=0 -DBOARD_SHUTDOWN_PIN=2 -DBOARD_SHUTDOWN_PIN_STATE=0"

XSCTH_COMPILER_DEBUG_FLAGS = "-O2 -DDEBUG_MODE -DENABLE_EM"
XSCTH_PROC_zynqmp = "psu_pmu_0"
XSCTH_APP  = "ZynqMP PMU Firmware"

INSANE_SKIP_${PN} = "arch"
INSANE_SKIP_${PN}-dbg = "arch"

do_deploy_append() {
    ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/pmu-${MACHINE}.elf
}
