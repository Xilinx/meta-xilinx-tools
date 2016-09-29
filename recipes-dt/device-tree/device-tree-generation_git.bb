DESCRIPTION = "DTS generator"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

DEPENDS += "dtc-native"

PROVIDES = "virtual/dtb"

inherit xsctdt deploy

S = "${WORKDIR}/git"
BRANCH = "master"
SRC_URI = "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https;branch=${BRANCH}"
SRCREV ?= "${AUTOREV}"

PV = "xilinx+git${SRCPV}"

XSCTH_APP = "device-tree"
do_install[noexec]="1"

DEVICETREE_FLAGS ?= ""

do_compile() {
    # use dtc to compile
    dtc -I dts -O dtb ${DEVICETREE_FLAGS} -o ${WORKDIR}/${PN}/${MACHINE}-system.dtb ${WORKDIR}/${PN}/system.dts
    dtc -I dtb -O dts -o ${WORKDIR}/${PN}/${MACHINE}-system.dts ${WORKDIR}/${PN}/${MACHINE}-system.dtb
}

do_deploy() {
    install -d ${DEPLOY_DIR_IMAGE}
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${MACHINE}-system.dts ${DEPLOY_DIR_IMAGE}/${MACHINE}-system.dts
    install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}/${MACHINE}-system.dtb ${DEPLOY_DIR_IMAGE}/${MACHINE}-system.dtb
}

addtask do_deploy after do_compile
