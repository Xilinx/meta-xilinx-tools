SUMMARY = "Xilinx BSP u-boot device trees"
DESCRIPTION = "Xilinx BSP u-boot device trees from within layer."
SECTION = "bsp"

LICENSE = "MIT & GPL-2.0-or-later"
LIC_FILES_CHKSUM = " \
                file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6 \
                "

require recipes-bsp/device-tree/device-tree.inc
inherit devicetree xsctdt xsctyaml

PROVIDES = "virtual/uboot-dtb"

S = "${WORKDIR}/git"
DT_VERSION_EXTENSION ?= "xilinx-${XILINX_RELEASE_VERSION}"
PV = "${DT_VERSION_EXTENSION}+git"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:zynqmp = ".*"
COMPATIBLE_MACHINE:zynq = ".*"
COMPATIBLE_MACHINE:versal = ".*"
COMPATIBLE_MACHINE:versal-net = ".*"

XSCTH_BUILD_CONFIG ?= ""

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"
DT_INCLUDE:append = " ${WORKDIR}"
DT_PADDING_SIZE = "0x1000"

UBOOT_DTS ?= ""
XSCTH_MISC = " -hdf_type ${HDF_EXT}"
XSCTH_APP = "device-tree"
UBOOT_DTS_NAME = "uboot-device-tree"

do_configure[dirs] += "${DT_FILES_PATH}"
SRC_URI:append = "${@" ".join(["file://%s" % f for f in (d.getVar('UBOOT_DTS') or "").split()])}"

do_configure:prepend () {
    if [ ! -z "${UBOOT_DTS}" ]; then
        for f in ${UBOOT_DTS}; do
            cp  ${WORKDIR}/${f} ${DT_FILES_PATH}/
        done
        return
    fi
}


#Both linux dtb and uboot dtb are installing
#system-top.dtb for uboot env recipe while do_prepare_recipe_sysroot
#moving system-top.dts to othername.
do_compile:prepend() {
    import shutil
    listpath = d.getVar("DT_FILES_PATH")
    if os.path.exists(os.path.join(listpath, "system.dts")):
        os.remove(os.path.join(listpath, "system.dts"))
    for file in os.listdir(listpath):
        try:
            if file.endswith(".dts"):
                shutil.move(os.path.join(listpath, file), os.path.join(listpath, d.getVar("UBOOT_DTS_NAME") + ".dts"))
        except OSError:
            pass
}

do_install() {
    for DTB_FILE in `ls *.dtb`; do
        install -Dm 0644 ${B}/${DTB_FILE} ${D}/boot/devicetree/${DTB_FILE}
    done
}


do_deploy() {
    for DTB_FILE in `ls *.dtb`; do
        install -Dm 0644 ${B}/${DTB_FILE} ${DEPLOYDIR}/${DTB_FILE}
    done
}
