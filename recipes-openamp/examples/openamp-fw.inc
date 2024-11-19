DESCRIPTION = "OpenAMP demo firmware"

ESW_VER = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '${XILINX_XSCT_VERSION}'}"

inherit check_xsct_enabled xsctapp xsctyaml deploy

LICENSE = "BSD-3-Clause"

PARALLEL_MAKE = "-j 1"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:microblaze = "^$"
# Build for actual machines, not the generics as the firmware require machine specific knowledge
COMPATIBLE_MACHINE:zynq = "${@'.*' if d.getVar('MACHINE') != 'zynq-generic' else '^$'}"
COMPATIBLE_MACHINE:zynqmp = "${@'.*' if d.getVar('MACHINE') != 'zynqmp-generic' else '^$'}"
COMPATIBLE_MACHINE:versal = "${@'.*' if d.getVar('MACHINE') != 'versal-generic' else '^$'}"
COMPATIBLE_MACHINE:versal-net = "${@'.*' if d.getVar('MACHINE') != 'versal-net-generic' else '^$'}"

XSCTH_APP_COMPILER_FLAGS:append:zynqmp = " -mfloat-abi=hard "
XSCTH_APP_COMPILER_FLAGS:append:versal = " -mfloat-abi=hard "
XSCTH_APP_COMPILER_FLAGS:append:versal-net = " -mfloat-abi=hard "

YAML_BSP_CONFIG += "WITH_PROXY"
YAML_BSP_CONFIG += "${@bb.utils.contains('SOC_FAMILY', 'zynq', 'extra_compiler_flags', '', d)}"
YAML_BSP_CONFIG[WITH_PROXY] = "set,false"
YAML_BSP_CONFIG[extra_compiler_flags] = "append,-DUSE_AMP=1"

FW_OS_NAME ?= "standalone"

XSCTH_MISC = "-osname ${FW_OS_NAME}"
XSCTH_PROC:versal-net ?= "psx_cortexr52_0"
XSCTH_PROC_IP:versal-net ?= "psx_cortexr52_0"
XSCTH_PROC_IP:versal ?= "psv_cortexr5"
XSCTH_PROC_IP:zynqmp ?= "psu_cortexr5"
XSCTH_PROC:zynq ?= "ps7_cortexa9_1"

DEBUG_PREFIX_MAP:remove = "-fcanon-prefix-map"

INSANE_SKIP:${PN} = "arch"

FW_LIB_DIR = "${nonarch_base_libdir}/firmware"

do_install() {
	install -d ${D}${FW_LIB_DIR}
	src=${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE}
	dest=${D}${FW_LIB_DIR}/${OPENAMP_FW_NAME}
	install -m 0644 ${src} ${dest}
}

FILES:${PN} = "${FW_LIB_DIR}/${OPENAMP_FW_NAME}"
