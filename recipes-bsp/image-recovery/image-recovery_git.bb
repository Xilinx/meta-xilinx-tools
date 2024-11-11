DESCRIPTION = "Image Recovery"

S = "${WORKDIR}/git"
DEPENDS += "bootgen-native fsbl-firmware"
inherit check_xsct_enabled xsctapp xsctyaml deploy


COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:zynqmp = "zynqmp"
COMPATIBLE_MACHINE:kria = "none"

XSCTH_APP:zynqmp = "Image Recovery"

do_configure:append () {
cat > ${WORKDIR}/${PN}.bif << EOF
        the_ROM_image:
        {
                [bootloader, destination_cpu=a53-0] ${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf 
                [load=0x10000000] ${S}/lib/sw_apps/img_rcvry/misc/web.img
                [destination_cpu=a53-0] ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE}
        }
EOF
}

do_compile:append () {
        bootgen -image ${WORKDIR}/${PN}.bif -arch ${SOC_FAMILY} -w -o ${B}/${XSCTH_PROJ}/${PN}.bin

        printf "* ${PN}\nSRCREV: ${SRCREV}\nBRANCH: ${BRANCH}\n\n" > ${S}/${PN}.manifest
}

do_deploy:append () {
        install -Dm 0644 ${B}/${XSCTH_PROJ}/${PN}.bin ${DEPLOYDIR}/${XSCTH_BASE_NAME}.bin
        ln -sf ${XSCTH_BASE_NAME}.bin ${DEPLOYDIR}/${PN}-${MACHINE}.bin

        install -Dm 0644 ${S}/lib/sw_apps/img_rcvry/misc/web.img ${DEPLOYDIR}/${PN}_web.img

        install -Dm 0644 ${S}/${PN}.manifest ${DEPLOYDIR}/${PN}-${MACHINE}.manifest
}
PARALLEL_MAKE = "-j1"
