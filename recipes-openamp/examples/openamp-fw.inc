DESCRIPTION = "OpenAMP demo firmware"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=4f2bb327107cbb7d887477d580652a89"

inherit xsctapp xsctyaml

# Sources, by default allow for the use of SRCREV pointing to orphaned tags/commits
ESWBRANCH ?= "master"
SRCBRANCHARG = "${@['nobranch=1', 'branch=${ESWBRANCH}'][d.getVar('ESWBRANCH', True) != '']}"

SRC_URI = "git://gitenterprise.xilinx.com/embeddedsw/embeddedsw.git;protocol=https;${SRCBRANCHARG}"

SRCREV ?= "${AUTOREV}"

PV ?= "master+git${SRCPV}"

S = "${WORKDIR}/git"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

YAML_FILE_PATH = "${WORKDIR}/openamp-examples.yaml"

YAML_APP_CONFIG = "build-config"
YAML_APP_CONFIG[build-config] = "set,release"

YAML_BSP_CONFIG_zynqmp = "WITH_PROXY"
YAML_BSP_CONFIG_zynq = "WITH_PROXY extra_compiler_flags"
YAML_BSP_CONFIG[WITH_PROXY] = "set,false"
YAML_BSP_CONFIG[extra_compiler_flags] = "append,-DUSE_AMP=1"

FW_OS_NAME ?= "freertos901_xilinx"

XSCTH_MISC ?= "-yamlconf ${YAML_FILE_PATH} -osname ${FW_OS_NAME}"
XSCTH_PROC_zynqmp ?= "psu_cortexr5_0"
XSCTH_PROC_zynq ?= "ps7_cortexa9_1"

INSANE_SKIP_${PN} = "arch"

BUILD_MODE_CONFIG ?= "${@['Debug', 'Release'][d.getVarFlags('YAML_APP_CONFIG')['build-config'].split(',')[1] != 'debug']}"

FW_LIB_DIR = "/lib/firmware"

do_install_append () {
	install -d ${D}${FW_LIB_DIR}
	src=${XSCTH_WS}/${XSCTH_PROJ}/${BUILD_MODE_CONFIG}/${XSCTH_PROJ}.elf
	dest=${D}${FW_LIB_DIR}/${OPENAMP_FW_NAME}
	install -m 0644 ${src} ${dest}
}

FILES_${PN} = "${FW_LIB_DIR}/${OPENAMP_FW_NAME}"
