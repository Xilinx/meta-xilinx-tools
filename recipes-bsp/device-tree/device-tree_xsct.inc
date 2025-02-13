DESCRIPTION = "Device Tree generation and packaging for BSP Device Trees using DTG from Xilinx"

PV = '${XILINX_XSCT_VERSION}+git'
PE = '1'

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=d2baf2c4690cd90d3c2c2efabfde5fd4"

# This file is shared with uboot-device-tree
require device-tree.inc

inherit xsctdt xsctyaml

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

S = "${WORKDIR}/git"
B = "${WORKDIR}/${BPN}-build"

XSCTH_BUILD_CONFIG = ""
YAML_COMPILER_FLAGS ?= ""
XSCTH_APP = "device-tree"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"
DT_RELEASE_VERSION ?= "${XILINX_XSCT_VERSION}"

PV .= "${@'' if d.getVar('DT_RELEASE_VERSION') == d.getVar('XILINX_XSCT_VERSION') else '+${DT_RELEASE_VERSION}'}"

DT_INCLUDE:append = " ${WORKDIR} ${S}/device_tree/data/kernel_dtsi/${DT_RELEASE_VERSION}/BOARD/"
DT_INCLUDE:append = " ${S}/device_tree/data/kernel_dtsi/${DT_RELEASE_VERSION}/include/"
DT_PADDING_SIZE = "0x1000"
DTC_FLAGS:append = "${@['', ' -@'][d.getVar('YAML_ENABLE_DT_OVERLAY') == '1']}"

SDFEC_EXTRA_DT_INCLUDE_FILES ??= ""
SDFEC_EXTRA_DT_INCLUDE_FILES:zcu111-zynqmp = " system-zcu111.dtsi"

EXTRA_DT_INCLUDE_FILES:append = "${@' ${SDFEC_EXTRA_DT_INCLUDE_FILES}' if d.getVar('ENABLE_SDFEC_DT') == '1' else ''}"
EXTRA_DT_INCLUDE_FILES:append:vek280-versal = " system-vek280.dtsi"
EXTRA_DT_INCLUDE_FILES:append:qemu-versal-net = " system-qemu-versal-net.dtsi"

COMPATIBLE_MACHINE:zynq = ".*"
COMPATIBLE_MACHINE:zynqmp = ".*"
COMPATIBLE_MACHINE:microblaze = ".*"
COMPATIBLE_MACHINE:versal = ".*"
COMPATIBLE_MACHINE:versal-net = ".*"

do_configure[cleandirs] += "${DT_FILES_PATH} ${B}"
do_deploy[cleandirs] += "${DEPLOYDIR}"

do_compile:prepend() {
    listpath = d.getVar("DT_FILES_PATH")
    try:
        os.remove(os.path.join(listpath, "system.dts"))
    except OSError:
        pass
}

do_install:append:microblaze () {
    for DTB_FILE in `ls *.dtb`; do
        dtc -I dtb -O dts -o ${D}/boot/devicetree/mb.dts ${B}/${DTB_FILE}
    done
}

FILES:${PN}:append:microblaze = " /boot/devicetree/*.dts"

EXTERNALSRC_SYMLINKS = ""

# This will generate the DTB, no need to check
def check_devicetree_variables(d):
    return
