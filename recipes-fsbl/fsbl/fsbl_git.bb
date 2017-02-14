DESCRIPTION = "FSBL"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

PROVIDES = "virtual/fsbl"

inherit xsctapp xsctyaml deploy

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

YAML_FILE_PATH = "${WORKDIR}/fsbl.yaml"
YAML_APP_CONFIG="build-config"
YAML_APP_CONFIG[build-config]="set,release"

XSCTH_MISC = "-yamlconf ${YAML_FILE_PATH}"
XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"
