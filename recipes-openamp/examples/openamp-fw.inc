DESCRIPTION = "OpenAMP demo firmware"

inherit xsctapp xsctyaml deploy

LICENSE = "BSD"

PARALLEL_MAKE = "-j 1"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynq = "zynq"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"
COMPATIBLE_MACHINE_versal = "versal"

XSCTH_APP_COMPILER_FLAGS_append_zynqmp = " -mfloat-abi=hard "
XSCTH_APP_COMPILER_FLAGS_append_versal = " -mfloat-abi=hard "

YAML_BSP_CONFIG += "WITH_PROXY"
YAML_BSP_CONFIG += "${@bb.utils.contains('SOC_FAMILY', 'zynq', 'extra_compiler_flags', '', d)}"
YAML_BSP_CONFIG[WITH_PROXY] = "set,false"
YAML_BSP_CONFIG[extra_compiler_flags] = "append,-DUSE_AMP=1"

FW_OS_NAME ?= "standalone"

XSCTH_MISC = "-osname ${FW_OS_NAME}"
XSCTH_PROC_IP_versal ?= "psv_cortexr5"
XSCTH_PROC_IP_zynqmp ?= "psu_cortexr5"
XSCTH_PROC_zynq ?= "ps7_cortexa9_1"

INSANE_SKIP_${PN} = "arch"

FW_LIB_DIR = "/lib/firmware"

do_install() {
	install -d ${D}${FW_LIB_DIR}
	src=${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE}
	dest=${D}${FW_LIB_DIR}/${OPENAMP_FW_NAME}
	install -m 0644 ${src} ${dest}
}

FILES_${PN} = "${FW_LIB_DIR}/${OPENAMP_FW_NAME}"
