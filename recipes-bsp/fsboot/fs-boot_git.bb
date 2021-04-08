DESCRIPTION = "FS-BOOT generator"

PROVIDES = "virtual/fsboot"

inherit xsctfsboot xsctyaml deploy

REPO ?="git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2020.2.2_k26"
SRCREV = "6d507ed8c006d8090aec8c10e24ef34706920884"

LIC_FILES_CHKSUM="file://license.txt;md5=64e026e5fcf32dffb500cb265cf57fe1"

MB_BAREMETAL_TOOLCHAIN_PATH_ADD = "${XILINX_SDK_TOOLCHAIN}/gnu/microblaze/lin/bin:"
PATH =. "${MB_BAREMETAL_TOOLCHAIN_PATH_ADD}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_microblaze = "microblaze"

XSCTH_APP = "mba_fs_boot"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"

PARALLEL_MAKE = ""
EXTRA_OEMAKE_BSP = ""
EXTRA_OEMAKE_APP = ""

do_compile() {
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_APP}_bsp ${EXTRA_OEMAKE_BSP} -j 1 && \
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ} ${EXTRA_OEMAKE_APP} -j 1
}

do_deploy_append() {
        ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/fsboot-${MACHINE}.elf
}
