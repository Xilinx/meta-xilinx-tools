BIF_PARTITION_ATTR_append_zynqmp = "${@bb.utils.contains('MACHINE_FEATURES', 'fpga-overlay', '', ' bitstream', d)}"

DEPENDS += 'u-boot-zynq-scr'

# Only adjust the depends when on versal
BOOTSCR_DEP = ''
BOOTSCR_DEP_versal = 'u-boot-zynq-scr:do_deploy'
do_compile[depends] .= " ${BOOTSCR_DEP}"

do_compile_append_versal() {
    dd if=/dev/zero bs=256M count=1  > ${B}/QEMU_qspi.bin
    dd if=${B}/BOOT.bin of=${B}/QEMU_qspi.bin bs=1 seek=0 conv=notrunc
    dd if=${DEPLOY_DIR_IMAGE}/boot.scr of=${B}/QEMU_qspi.bin bs=1 seek=66584576 conv=notrunc
}

do_deploy_append_versal () {
    install -m 0644 ${B}/QEMU_qspi.bin ${DEPLOYDIR}/${QEMUQSPI_BASE_NAME}.bin
    ln -sf ${QEMUQSPI_BASE_NAME}.bin ${DEPLOYDIR}/QEMU_qspi-${MACHINE}.bin
}
