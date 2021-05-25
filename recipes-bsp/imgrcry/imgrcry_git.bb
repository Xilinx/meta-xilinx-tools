DESCRIPTION = "Image Recovery"

S = "${WORKDIR}/git"
PROVIDES = "virtual/imgrcry"
DEPENDS += "bootgen-native fsbl-firmware"
inherit xsctapp xsctyaml deploy


COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_zynqmp = "zynqmp"

XSCTH_APP_zynqmp = "Image Recovery"

do_configure_append () {
cat > ${WORKDIR}/${PN}.bif << EOF
        the_ROM_image:
        {
                [bootloader, destination_cpu=a53-0] ${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf 
                [load=0x10000000] ${S}/lib/sw_apps/img_rcvry/misc/web.img
                [destination_cpu=a53-0] ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE}
        }
EOF
}

do_compile_append () {
        bootgen -image ${WORKDIR}/${PN}.bif -arch ${SOC_FAMILY} -w -o ${B}/${XSCTH_PROJ}/${PN}.bin
}

do_deploy_append () {
        install -Dm 0644 ${B}/${XSCTH_PROJ}/${PN}.bin ${DEPLOYDIR}/${XSCTH_BASE_NAME}.bin
        ln -sf ${XSCTH_BASE_NAME}.bin ${DEPLOYDIR}/${PN}-${MACHINE}.bin

        install -Dm 0644 ${S}/lib/sw_apps/img_rcvry/misc/web.img ${DEPLOYDIR}/imgrcry_web.img
}
PARALLEL_MAKE = "-j1"
