DESCRIPTION = "DTS generator"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

DEPENDS += "dtc-native"

PROVIDES = "virtual/dtb"

inherit xsctdt xsctyaml deploy

S = "${WORKDIR}/git"
BRANCH = "master"
SRC_URI = "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https;branch=${BRANCH}"
#Based on xilinx-v2017.3
SRCREV ?= "5b21302249df23f0de9b3b6ec4c75704339e3414"

PV = "xilinx+git${SRCPV}"

XSCTH_BUILD_CONFIG = ""
YAML_COMPILER_FLAGS = ""
XSCTH_APP = "device-tree"

YAML_MAIN_MEMORY_CONFIG_zcu100-zynqmp = "psu_ddr_0"
YAML_CONSOLE_DEVICE_CONFIG_zcu100-zynqmp = "psu_uart_1"

YAML_DT_BOARD_FLAGS_zcu100-zynqmp = "{BOARD zcu100-revc}"
YAML_DT_BOARD_FLAGS_zcu102-zynqmp = "{BOARD zcu102-rev1.0}"
YAML_DT_BOARD_FLAGS_zcu106-zynqmp = "{BOARD zcu106-reva}"
YAML_DT_BOARD_FLAGS_zc702-zynq7 = "{BOARD zc702}"
YAML_DT_BOARD_FLAGS_zc706-zynq7 = "{BOARD zc706}"
YAML_DT_BOARD_FLAGS_zedboard-zynq7 = "{BOARD zedboard}"
YAML_DT_BOARD_FLAGS_zc1254-zynqmp = "{BOARD zc1254-reva}"

DEVICETREE_WORKDIR ?= "${XSCTH_WS}/${XSCTH_PROJ}"

DT_PADDING_SIZE ?= "0x1000"

DEVICETREE_FLAGS ?= "-R 8 -p ${DT_PADDING_SIZE} \
		-i ${WORKDIR} \
		-i ${DEVICETREE_WORKDIR} \
		"

DEVICETREE_PP_FLAGS ?= "-nostdinc -Ulinux \
		-I${WORKDIR} \
		-I${DEVICETREE_WORKDIR} \
		${@' '.join(['-I%s' % i for i in d.getVar('KERNEL_DTS_INCLUDE', True).split()])} \
		-x assembler-with-cpp \
		"

KERNEL_DTS_INCLUDE ??= "${STAGING_KERNEL_DIR}/include"

do_compile[depends] += "virtual/kernel:do_configure"
do_compile() {
    # use dtc to compile
    ${BUILD_CPP} ${DEVICETREE_PP_FLAGS} -o ${DEVICETREE_WORKDIR}/${MACHINE}-system.pp ${DEVICETREE_WORKDIR}/system-top.dts
    dtc -I dts -O dtb ${DEVICETREE_FLAGS} -o ${DEVICETREE_WORKDIR}/${MACHINE}-system.dtb ${DEVICETREE_WORKDIR}/${MACHINE}-system.pp
    dtc -I dtb -O dts -o ${DEVICETREE_WORKDIR}/${MACHINE}-system.dts ${DEVICETREE_WORKDIR}/${MACHINE}-system.dtb
}

do_install() {
    install -d ${D}/boot/devicetree
    install -m 0644 ${DEVICETREE_WORKDIR}/${MACHINE}-system.dtb ${D}/boot/devicetree/${MACHINE}-system.dtb
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${DEVICETREE_WORKDIR}/${MACHINE}-system.dts ${DEPLOYDIR}/${MACHINE}-system.dts
    install -m 0644 ${DEVICETREE_WORKDIR}/${MACHINE}-system.dtb ${DEPLOYDIR}/${MACHINE}-system.dtb
}
addtask deploy after do_install

FILES_${PN} = "/boot/devicetree*"
