DESCRIPTION = "PMU Firmware"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

PROVIDES = "virtual/pmufw"

inherit xsctapp xsctyaml deploy

S = "${WORKDIR}/git"

# Sources, by default allow for the use of SRCREV pointing to orphaned tags/commits
ESWBRANCH ?= ""
SRCBRANCHARG = "${@['nobranch=1', 'branch=${ESWBRANCH}'][d.getVar('ESWBRANCH', True) != '']}"

SRC_URI = "git://github.com/Xilinx/embeddedsw.git;protocol=https;${SRCBRANCHARG}"

# This points to xilinx-v2016.4 tag
SRCREV ?= "a931a8d4471ad6d1e1ecdfd41f1da66d98d6f137"

PV = "0.2+xilinx+git${SRCPV}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

YAML_FILE_PATH = "${WORKDIR}/pmufw.yaml"
YAML_APP_CONFIG="build-config"
YAML_APP_CONFIG[build-config]="set,release"

XSCTH_PROC_zynqmp = "psu_pmu_0"
XSCTH_APP  = "ZynqMP PMU Firmware"
XSCTH_MISC = "-yamlconf ${YAML_FILE_PATH}"

do_install[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/Release/${XSCTH_PROJ}.elf ${DEPLOYDIR}/pmu-${MACHINE}.elf
}

addtask do_deploy after do_compile
