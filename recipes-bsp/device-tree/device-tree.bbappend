DESCRIPTION = "Device Tree generation and packaging for BSP Device Trees using DTG from Xilinx"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

PROVIDES = "virtual/dtb"

# We only want to add the bootbin setup for Linux based builds
# For instance, baremetal won't support this
BOOTBININHERIT = "${@'bootbin-component' if d.getVar('TARGET_OS').startswith('linux') else ''}"
inherit xsctdt xsctyaml ${BOOTBININHERIT}

BOOTBIN_BIF_FRAGMENT_zynqmp = "load=0x100000"
BOOTBIN_BIF_FRAGMENT_zynq = "load=0x100000"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

S = "${WORKDIR}/git"

REPO ??= "git://github.com/xilinx/device-tree-xlnx.git;protocol=https"
BRANCH ??= "master"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

#Based on xilinx-v2020.1
SRCREV ??= "bc8445833318e9320bf485ea125921eecc3dc97a"

DT_VERSION_EXTENSION ?= "xilinx-${XILINX_RELEASE_VERSION}"
PV = "${DT_VERSION_EXTENSION}+git${SRCPV}"

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
YAML_DT_BOARD_FLAGS_zcu1275-zynqmp ?= "{BOARD zcu1275-revb}"
YAML_DT_BOARD_FLAGS_zcu1285-zynqmp ?= "{BOARD zcu1285-reva}"
YAML_DT_BOARD_FLAGS_zcu216-zynqmp ?= "{BOARD zcu216-reva}"
YAML_DT_BOARD_FLAGS_zcu208-zynqmp ?= "{BOARD zcu208-reva}"
YAML_DT_BOARD_FLAGS_virt-versal ?= "{BOARD versal-virt}"
YAML_DT_BOARD_FLAGS_versal-generic ?= "{BOARD versal-vc-p-a2197-00-reva-x-prc-01-reva}"
YAML_DT_BOARD_FLAGS_vck-sc-zynqmp ?= "{BOARD zynqmp-e-a2197-00-reva}"
YAML_DT_BOARD_FLAGS_v350-versal ?= "{BOARD versal-v350-reva}"
YAML_DT_BOARD_FLAGS_vck190-versal ?= "{BOARD versal-vck190-reva-x-ebm-01-reva}"
YAML_DT_BOARD_FLAGS_vmk180-versal ?= "{BOARD versal-vmk180-reva-x-ebm-01-reva}"
YAML_DT_BOARD_FLAGS_vc-p-a2197-00-versal ?= "{BOARD versal-vc-p-a2197-00-reva-x-prc-01-reva}"

YAML_OVERLAY_CUSTOM_DTS = "pl-final.dts"
CUSTOM_PL_INCLUDE_DTSI ?= ""

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"
DT_INCLUDE_append = " ${WORKDIR}"
DT_PADDING_SIZE = "0x1000"
DTC_FLAGS_append = "${@['', ' -@'][d.getVar('YAML_ENABLE_DT_OVERLAY') == '1']}"
KERNEL_INCLUDE_append = " ${STAGING_KERNEL_DIR}/include"

COMPATIBLE_MACHINE_zynq = ".*"
COMPATIBLE_MACHINE_zynqmp = ".*"
COMPATIBLE_MACHINE_microblaze = ".*"
COMPATIBLE_MACHINE_versal = ".*"

SRC_URI_append_ultra96-zynqmp = "${@bb.utils.contains('MACHINE_FEATURES', 'mipi', ' file://mipi-support-ultra96.dtsi', '', d)}"

do_configure_append_ultra96-zynqmp() {
        if [ -e ${WORKDIR}/mipi-support-ultra96.dtsi ]; then
               cp ${WORKDIR}/mipi-support-ultra96.dtsi ${DT_FILES_PATH}/mipi-support-ultra96.dtsi
               echo '/include/ "mipi-support-ultra96.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        fi
}

do_configure_append () {
    if [ -n "${CUSTOM_PL_INCLUDE_DTSI}" ]; then
        [ ! -f "${CUSTOM_PL_INCLUDE_DTSI}" ] && bbfatal "Please check that the correct filepath was provided using CUSTOM_PL_INCLUDE_DTSI"
        cp ${CUSTOM_PL_INCLUDE_DTSI} ${XSCTH_WS}/${XSCTH_PROJ}/pl-custom.dtsi
    fi
}

do_compile_prepend() {
    listpath = d.getVar("DT_FILES_PATH")
    try:
        os.remove(os.path.join(listpath, "system.dts"))
    except OSError:
        pass
}

BINARY_EXT = ".dtb"
#installing base dtb in proper format for updateboot
do_install_append () {
    install -Dm 0644 ${B}/*.dtb ${D}/boot/${PN}-${SRCPV}${BINARY_EXT}
}
FILES_${PN} += "/boot/${PN}-${SRCPV}${BINARY_EXT}"

DTB_BASE_NAME ?= "${MACHINE}-system-${DATETIME}"
DTB_BASE_NAME[vardepsexclude] = "DATETIME"

do_install_append_microblaze () {
    for DTB_FILE in `ls *.dtb`; do
        dtc -I dtb -O dts -o ${D}/boot/devicetree/mb.dts ${B}/${DTB_FILE}
    done
}

do_deploy() {
	for DTB_FILE in `ls *.dtb *.dtbo`; do
		install -Dm 0644 ${B}/${DTB_FILE} ${DEPLOYDIR}/${DTB_BASE_NAME}.${DTB_FILE#*.}
		ln -sf ${DTB_BASE_NAME}.${DTB_FILE#*.} ${DEPLOYDIR}/${MACHINE}-system.${DTB_FILE#*.}
		ln -sf ${DTB_BASE_NAME}.${DTB_FILE#*.} ${DEPLOYDIR}/system.${DTB_FILE#*.}
	done
}

FILES_${PN}_append_microblaze = " /boot/devicetree/*.dts"

EXTERNALSRC_SYMLINKS = ""
