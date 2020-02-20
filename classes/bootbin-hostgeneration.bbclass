inherit deploy

BOOTBIN_BASE_NAME ?= "BOOT-${MACHINE}-${DATETIME}"
BOOTBIN_BASE_NAME[vardepsexclude] = "DATETIME"

DEPENDS += "updateboot bootgen-native"

ROOTFS_POSTPROCESS_COMMAND += "boot_bin; "

#This is for boot.bin generation on host.
#after all bootcomponents are installed during do_rootfs, generate bif and generate boot.bin, then deploy
boot_bin() {
    ${IMAGE_ROOTFS}/${bindir}/updateboot ${IMAGE_ROOTFS}/boot
    bootgen -image ${IMAGE_ROOTFS}/boot/bootgen.bif -arch ${SOC_FAMILY} ${BOOTGEN_EXTRA_ARGS} -w -o ${IMAGE_ROOTFS}/boot/BOOT.bin
    install -d ${DEPLOY_DIR_IMAGE}
    install -m 0644 ${IMAGE_ROOTFS}/boot/BOOT.bin ${DEPLOY_DIR_IMAGE}/${BOOTBIN_BASE_NAME}.bin_NEWFLOW
    ln -sf ${BOOTBIN_BASE_NAME}.bin_NEWFLOW ${DEPLOY_DIR_IMAGE}/BOOT-${MACHINE}.bin_NEWFLOW
    #removing bif file created for host
    rm ${IMAGE_ROOTFS}/boot/bootgen.bif
}
