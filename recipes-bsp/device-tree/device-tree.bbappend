DESCRIPTION = "Device Tree generation and packaging for BSP Device Trees using DTG from Xilinx"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

PROVIDES = "virtual/dtb"

inherit xsctdt xsctyaml

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

S = "${WORKDIR}/git"

REPO ??= "git://github.com/xilinx/device-tree-xlnx.git;protocol=https"
BRANCH ??= "master"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

#Based on xilinx-v2018.3
SRCREV ??= "b7466bbeeede15ec72143e3c3466e067589821a1"

PV = "xilinx+git${SRCPV}"

XSCTH_BUILD_CONFIG = ""
YAML_COMPILER_FLAGS ?= ""
XSCTH_APP = "device-tree"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"

YAML_MAIN_MEMORY_CONFIG_ultra96-zynqmp ?= "psu_ddr_0"
YAML_CONSOLE_DEVICE_CONFIG_ultra96-zynqmp ?= "psu_uart_1"

YAML_MAIN_MEMORY_CONFIG_kc705-microblazeel ?= "ddr3_sdram"
YAML_CONSOLE_DEVICE_CONFIG_kc705-microblazeel ?= "rs232_uart"

YAML_DT_BOARD_FLAGS_ultra96-zynqmp ?= "{BOARD avnet-ultra96-rev1}"
YAML_DT_BOARD_FLAGS_zcu102-zynqmp ?= "{BOARD zcu102-rev1.0}"
YAML_DT_BOARD_FLAGS_zcu106-zynqmp ?= "{BOARD zcu106-reva}"
YAML_DT_BOARD_FLAGS_zc702-zynq7 ?= "{BOARD zc702}"
YAML_DT_BOARD_FLAGS_zc706-zynq7 ?= "{BOARD zc706}"
YAML_DT_BOARD_FLAGS_zedboard-zynq7 ?= "{BOARD zedboard}"
YAML_DT_BOARD_FLAGS_zc1254-zynqmp ?= "{BOARD zc1254-reva}"
YAML_DT_BOARD_FLAGS_kc705-microblazeel ?= "{BOARD kc705-full}"
YAML_DT_BOARD_FLAGS_zcu104-zynqmp ?= "{BOARD zcu104-revc}"
YAML_DT_BOARD_FLAGS_zcu111-zynqmp ?= "{BOARD zcu111-reva}"
YAML_DT_BOARD_FLAGS_zc1275-zynqmp ?= "{BOARD zc1275-revb}"

DTS_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"
DTS_INCLUDE_append = " ${WORKDIR}"
DT_PADDING_SIZE = "0x1000"
KERNEL_DTS_INCLUDE_append = " ${STAGING_KERNEL_DIR}/include"

COMPATIBLE_MACHINE_zynq = ".*"
COMPATIBLE_MACHINE_zynqmp = ".*"
COMPATIBLE_MACHINE_microblaze = ".*"

SRC_URI_append_ultra96-zynqmp = "${@bb.utils.contains('MACHINE_FEATURES', 'mipi', ' file://mipi-support-ultra96.dtsi', '', d)}"

do_configure_append_ultra96-zynqmp() {
        if [ -e ${WORKDIR}/mipi-support-ultra96.dtsi ]; then
               cp ${WORKDIR}/mipi-support-ultra96.dtsi ${DTS_FILES_PATH}/mipi-support-ultra96.dtsi
               echo '/include/ "mipi-support-ultra96.dtsi"' >> ${DTS_FILES_PATH}/system-top.dts
        fi
}


do_compile_prepend_kc705-microblazeel() {
	cp ${WORKDIR}/system-conf.dtsi ${DTS_FILES_PATH}
	cp ${WORKDIR}/kc705-microblazeel.dts ${DTS_FILES_PATH}
}

do_compile_prepend() {
	[ -e ${DTS_FILES_PATH}/system.dts ] && rm ${DTS_FILES_PATH}/system.dts
}

DTB_BASE_NAME ?= "${MACHINE}-system-${DATETIME}"
DTB_BASE_NAME[vardepsexclude] = "DATETIME"

do_deploy() {
	for DTB_FILE in `ls *.dtb *.dtbo`; do
		install -Dm 0644 ${B}/${DTB_FILE} ${DEPLOYDIR}/${DTB_BASE_NAME}.${DTB_FILE#*.}
		ln -sf ${DTB_BASE_NAME}.${DTB_FILE#*.} ${DEPLOYDIR}/${MACHINE}-system.${DTB_FILE#*.}
	done
}
