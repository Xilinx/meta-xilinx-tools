DESCRIPTION = "Image Recovery"
RCONFLICTS:${PN} = "imgrcry"
DEPENDS += "bootgen-native fsbl-firmware"

inherit check_xsct_enabled deploy xlnx-embeddedsw xsctbase image-artifact-names

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://../../../../license.txt;md5=${@d.getVarFlag('LIC_FILES_CHKSUM', d.getVar('BRANCH')) or '0'}"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:kria = "${MACHINE}"
COMPATIBLE_MACHINE:eval-brd-sc-zynqmp = "${MACHINE}"

EXTRA_OEMAKE:append:eval-brd-sc-zynqmp = "BOARD=SC"

S = "${WORKDIR}/git/lib/sw_apps/img_rcvry/src"

PARALLEL_MAKE = "-j 1"

XSCTH_EXECUTABLE = "ImgRecovery.elf"

do_configure () {
cat > ${WORKDIR}/${PN}.bif << EOF
    the_ROM_image:
    {
        [bootloader, destination_cpu=a53-0] ${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf
        [load=0x10000000] ${S}/../misc/web.img
        [destination_cpu=a53-0] ${S}/${XSCTH_EXECUTABLE}
    }
EOF
}

do_compile () {
    oe_runmake all
    bootgen -image ${WORKDIR}/${PN}.bif -arch ${SOC_FAMILY} -w -o ${B}/${PN}.bin

    printf "* ${PN}\nSRCREV: ${SRCREV}\nBRANCH: ${BRANCH}\n\n" > ${S}/${PN}.manifest
}

do_deploy () {
    install -Dm 0644 ${S}/../misc/web.img ${DEPLOYDIR}/imgrcry_web.img
    install -Dm 0644 ${B}/${PN}.bin ${DEPLOYDIR}/${PN}-${MACHINE}-${IMAGE_VERSION_SUFFIX}.bin
    ln -sf ${PN}-${MACHINE}-${IMAGE_VERSION_SUFFIX}.bin ${DEPLOYDIR}/imgrcry-${MACHINE}.bin

    install -Dm 0644 ${S}/${PN}.manifest ${DEPLOYDIR}/${PN}-${MACHINE}-${IMAGE_VERSION_SUFFIX}.manifest
    ln -sf ${PN}-${MACHINE}-${IMAGE_VERSION_SUFFIX}.manifest ${DEPLOYDIR}/imgrcry-${MACHINE}.manifest
}

addtask do_deploy after do_compile
