DESCRIPTION = "PMU Firmware"

PROVIDES = "virtual/pmu-firmware"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_MISC_append_zynqmpdr = " -lib libmetal"

XSCTH_COMPILER_DEBUG_FLAGS = "-DDEBUG_MODE -DXPFW_DEBUG_DETAILED"
XSCTH_PROC_zynqmp = "psu_pmu_0"
XSCTH_APP  = "ZynqMP PMU Firmware"

ULTRA96_VERSION ?= "1"
YAML_COMPILER_FLAGS_append = " -DENABLE_MOD_ULTRA96 -DENABLE_SCHEDULER "
YAML_COMPILER_FLAGS_append_ultra96-zynqmp = "${@bb.utils.contains('ULTRA96_VERSION', '2', ' -DULTRA96_VERSION=2 ', ' -DULTRA96_VERSION=1 ', d)}" 

INSANE_SKIP_${PN} = "arch"
INSANE_SKIP_${PN}-dbg = "arch"

do_deploy_append() {
    ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/pmu-${MACHINE}.elf
}
