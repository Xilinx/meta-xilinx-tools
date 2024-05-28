DESCRIPTION = "FS-BOOT generator"

PROVIDES = "virtual/fsboot"

inherit check_xsct_enabled xsctfsboot xsctyaml deploy

MB_BAREMETAL_TOOLCHAIN_PATH_ADD = "${XILINX_SDK_TOOLCHAIN}/gnu/microblaze/lin/bin:"
PATH =. "${MB_BAREMETAL_TOOLCHAIN_PATH_ADD}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:microblaze = "microblaze"

XSCTH_APP = "mba_fs_boot"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"

PARALLEL_MAKE = ""
EXTRA_OEMAKE_BSP = ""
EXTRA_OEMAKE_APP = ""

do_compile() {
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ}/${XSCTH_APP}_bsp ${EXTRA_OEMAKE_BSP} -j 1 && \
        oe_runmake -C ${XSCTH_WS}/${XSCTH_PROJ} ${EXTRA_OEMAKE_APP} -j 1
}

do_deploy:append() {
        ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/fsboot-${MACHINE}.elf
}
