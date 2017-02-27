DESCRIPTION = "DTS generator"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

DEPENDS += "dtc-native"

PROVIDES = "virtual/dtb"

inherit xsctdt xsctyaml deploy

S = "${WORKDIR}/git"
BRANCH = "master"
SRC_URI = "git://gitenterprise.xilinx.com/Linux/device-tree-xlnx.git;protocol=https;branch=${BRANCH}"
#Based on xilinx-v2017.1
SRCREV ?= "341b6938a824204c0613ca937906ef924292f0c2"

PV = "xilinx+git${SRCPV}"

XSCTH_BUILD_CONFIG = ""
YAML_COMPILER_FLAGS = ""
XSCTH_APP = "device-tree"

YAML_MAIN_MEMORY_CONFIG_zynqmp = "psu_ddr_0"
YAML_CONSOLE_DEVICE_CONFIG_zynqmp = "psu_uart_0"

YAML_MAIN_MEMORY_CONFIG_zynq = "ps7_ddr_0"
YAML_CONSOLE_DEVICE_CONFIG_zynq = "ps7_uart_1"

YAML_DT_BOARD_FLAGS_zcu102-zynqmp = "{BOARD zcu102}"
YAML_DT_BOARD_FLAGS_zcu106-zynqmp = "{BOARD zcu106}"
YAML_DT_BOARD_FLAGS_zc702-zynq7 = "{BOARD zc702}"
YAML_DT_BOARD_FLAGS_zc706-zynq7 = "{BOARD zc706}"
YAML_DT_BOARD_FLAGS_zedboard-zynq7 = "{BOARD zedboard}"

do_install[noexec]="1"

DEVICETREE_FLAGS ?= ""

do_compile() {
    # use dtc to compile
    dtc -I dts -O dtb ${DEVICETREE_FLAGS} -o ${WORKDIR}/${PN}/${MACHINE}-system.dtb ${WORKDIR}/${PN}/system-top.dts
    dtc -I dtb -O dts -o ${WORKDIR}/${PN}/${MACHINE}-system.dts ${WORKDIR}/${PN}/${MACHINE}-system.dtb
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${MACHINE}-system.dts ${DEPLOYDIR}/${MACHINE}-system.dts
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${MACHINE}-system.dtb ${DEPLOYDIR}/${MACHINE}-system.dtb
}

addtask do_deploy after do_compile
