DESCRIPTION = "Image Recovery"
DEPENDS += "bootgen-native fsbl-firmware"

inherit check_xsct_enabled deploy xlnx-embeddedsw xsctbase

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:kria = "${MACHINE}"
COMPATIBLE_MACHINE:eval-brd-sc-zynqmp = "${MACHINE}"

EXTRA_OEMAKE:append:eval-brd-sc-zynqmp = "BOARD=SC"

B = "${WORKDIR}/git/lib/sw_apps/img_rcvry/src"

PARALLEL_MAKE = "-j 1"

XSCTH_EXECUTABLE = "ImgRecovery.elf"

do_configure () {
cat > ${WORKDIR}/${PN}.bif << EOF
    the_ROM_image:
    {
        [bootloader, destination_cpu=a53-0] ${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf
        [load=0x10000000] ${B}/../misc/web.img
        [destination_cpu=a53-0] ${B}/${XSCTH_EXECUTABLE}
    }
EOF
}

do_compile () {
    oe_runmake all

    bootgen -image ${WORKDIR}/${PN}.bif -arch ${SOC_FAMILY} -w -o ${B}/${PN}.bin

    printf "* ${PN}\nSRCREV: ${SRCREV}\nBRANCH: ${BRANCH}\n\n" > ${S}/${PN}.manifest
}

do_deploy () {
    install -Dm 0644 ${B}/../misc/web.img ${DEPLOYDIR}/image-recovery_web.img
    install -Dm 0644 ${B}/${PN}.bin ${DEPLOYDIR}/${PN}-${MACHINE}-${IMAGE_VERSION_SUFFIX}.bin
    ln -sf ${PN}-${MACHINE}-${IMAGE_VERSION_SUFFIX}.bin ${DEPLOYDIR}/image-recovery-${MACHINE}.bin

    install -Dm 0644 ${S}/${PN}.manifest ${DEPLOYDIR}/image-recovery-${MACHINE}.manifest
}

addtask do_deploy after do_compile
