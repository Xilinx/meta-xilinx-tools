DESCRIPTION = "Device Tree generation and packaging for BSP Device Trees using DTG from Xilinx"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

require recipes-bsp/device-tree/device-tree.inc
inherit xsctdt xsctyaml
BASE_DTS ?= "system-top"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

S = "${WORKDIR}/git"
B = "${WORKDIR}/${BPN}-build"

DT_VERSION_EXTENSION ?= "xilinx-${XILINX_RELEASE_VERSION}"
PV = "${DT_VERSION_EXTENSION}+git${SRCPV}"

XSCTH_BUILD_CONFIG = ""
YAML_COMPILER_FLAGS ?= ""
XSCTH_APP = "device-tree"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"

YAML_OVERLAY_CUSTOM_DTS = "pl-final.dts"
CUSTOM_PL_INCLUDE_DTSI ?= ""
EXTRA_DT_FILES ?= ""
EXTRA_DTFILE_PREFIX ?= "system-top"
EXTRA_DTFILES_BUNDLE ?= ""
UBOOT_DT_FILES ?= ""
UBOOT_DTFILE_PREFIX ?= "system-top"
UBOOT_DTFILES_BUNDLE ?= ""
EXTRA_OVERLAYS ?= ""

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"
DT_RELEASE_VERSION ?= "${XILINX_VER_MAIN}"
DT_INCLUDE:append = " ${WORKDIR} ${S}/device_tree/data/kernel_dtsi/${DT_RELEASE_VERSION}/BOARD/"
DT_PADDING_SIZE = "0x1000"
DTC_FLAGS:append = "${@['', ' -@'][d.getVar('YAML_ENABLE_DT_OVERLAY') == '1']}"

COMPATIBLE_MACHINE:zynq = ".*"
COMPATIBLE_MACHINE:zynqmp = ".*"
COMPATIBLE_MACHINE:microblaze = ".*"
COMPATIBLE_MACHINE:versal = ".*"

SRC_URI:append = "${@" ".join(["file://%s" % f for f in (d.getVar('EXTRA_DT_FILES') or "").split()])}"
SRC_URI:append = "${@['', ' file://${CUSTOM_PL_INCLUDE_DTSI}'][d.getVar('CUSTOM_PL_INCLUDE_DTSI') != '']}"
SRC_URI:append = "${@" ".join(["file://%s" % f for f in (d.getVar('EXTRA_OVERLAYS') or "").split()])}"

do_configure[cleandirs] += "${DT_FILES_PATH} ${B}"
do_deploy[cleandirs] += "${DEPLOYDIR}"

do_configure:append () {
    if [ -n "${CUSTOM_PL_INCLUDE_DTSI}" ]; then
        [ ! -f "${WORKDIR}/${CUSTOM_PL_INCLUDE_DTSI}" ] && bbfatal "Please check that the correct filepath was provided using CUSTOM_PL_INCLUDE_DTSI"
        cp ${WORKDIR}/${CUSTOM_PL_INCLUDE_DTSI} ${XSCTH_WS}/${XSCTH_PROJ}/pl-custom.dtsi
    fi

    for f in ${EXTRA_DT_FILES}; do
        cp ${WORKDIR}/${f} ${DT_FILES_PATH}/
    done

    for f in ${EXTRA_OVERLAYS}; do
        cp ${WORKDIR}/${f} ${DT_FILES_PATH}/
        echo "/include/ \"$f\"" >> ${DT_FILES_PATH}/${BASE_DTS}.dts
    done
}

devicetree_do_compile:append() {
    import subprocess

    dtb_file = d.getVar('DTB_FILE_NAME') or ''
    if not dtb_file or not os.path.isfile(dtb_file):
        return

    if d.getVar('EXTRA_DTFILES_BUNDLE'):
        ccdtb_prefix = d.getVar('EXTRA_DTFILE_PREFIX')
        extra_dt_files = d.getVar('EXTRA_DT_FILES').split() or []

        for dtsfile in extra_dt_files:
            dtname = os.path.splitext(os.path.basename(dtsfile))[0]
            if os.path.isfile(f"{dtname}.dtbo"):
                fdtargs = ["fdtoverlay", "-o", f"{ccdtb_prefix}-{dtname}.dtb", "-i", dtb_file, f"{dtname}.dtbo"]
                bb.note("Running {0}".format(" ".join(fdtargs)))
                subprocess.run(fdtargs, check = True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    if d.getVar('UBOOT_DTFILES_BUNDLE'):
        uboot_ccdtb_prefix = d.getVar('UBOOT_DTFILE_PREFIX')
        uboot_dt_files = d.getVar('UBOOT_DT_FILES').split() or []

        for dtsfile in uboot_dt_files:
            dtname = os.path.splitext(os.path.basename(dtsfile))[0]
            if os.path.isfile(f"{dtname}.dtbo"):
                fdtargs = ["fdtoverlay", "-o", f"{uboot_ccdtb_prefix}-{dtname}.dtb", "-i", dtb_file, f"{dtname}.dtbo"]
                bb.note("Running {0}".format(" ".join(fdtargs)))
                subprocess.run(fdtargs, check = True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
}

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

DTB_FILE_NAME = "${BASE_DTS}.dtb"

FILES:${PN}:append:microblaze = " /boot/devicetree/*.dts"

EXTERNALSRC_SYMLINKS = ""

# This will generate the DTB, no need to check
def check_devicetree_variables(d):
    return
