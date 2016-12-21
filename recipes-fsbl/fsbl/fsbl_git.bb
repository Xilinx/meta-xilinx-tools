DESCRIPTION = "FSBL"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

PROVIDES = "virtual/fsbl"

inherit xsctapp xsctyaml deploy

S = "${WORKDIR}/git"
BRANCH = "master"
SRC_URI = "git://github.com/Xilinx/embeddedsw.git;protocol=https;branch=${BRANCH}"

# This points to xilinx-v2016.4 tag
SRCREV ?= "a931a8d4471ad6d1e1ecdfd41f1da66d98d6f137"

PV = "0.2+xilinx+git${SRCPV}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

YAML_FILE_PATH = "${WORKDIR}/fsbl.yaml"
YAML_APP_CONFIG="build-config"
YAML_APP_CONFIG[build-config]="set,release"

XSCTH_MISC = "-yamlconf ${YAML_FILE_PATH}"
XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"

do_install[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/Release/fsbl.elf ${DEPLOYDIR}/fsbl-${MACHINE}.elf
}
addtask do_deploy after do_compile
