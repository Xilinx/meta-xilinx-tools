DESCRIPTION = "PMU Firmware"

PROVIDES = "virtual/pmu-firmware"

inherit xsctapp xsctyaml deploy bootbin-component

BOOTBIN_BIF_FRAGMENT_zynqmp = "destination_cpu=pmu"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_MISC_append_zynqmp-dr = " -lib libmetal"

XSCTH_COMPILER_DEBUG_FLAGS = "-DDEBUG_MODE -DXPFW_DEBUG_DETAILED"
XSCTH_PROC_zynqmp = "psu_pmu_0"
XSCTH_APP  = "ZynqMP PMU Firmware"

ULTRA96_VERSION ?= "1"
YAML_COMPILER_FLAGS_append = " -DENABLE_SCHEDULER "
YAML_COMPILER_FLAGS_append_ultra96-zynqmp = " -DENABLE_MOD_ULTRA96 ${@bb.utils.contains('ULTRA96_VERSION', '2', ' -DULTRA96_VERSION=2 ', ' -DULTRA96_VERSION=1 ', d)}"
YAML_COMPILER_FLAGS_append_k26 = " -DBOARD_SHUTDOWN_PIN=2 -DBOARD_SHUTDOWN_PIN_STATE=0 -DENABLE_EM -DENABLE_MOD_OVERTEMP -DOVERTEMP_DEGC=90.0 "

INSANE_SKIP_${PN} = "arch"
INSANE_SKIP_${PN}-dbg = "arch"

do_deploy_append() {
    ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/pmu-${MACHINE}.elf
}
