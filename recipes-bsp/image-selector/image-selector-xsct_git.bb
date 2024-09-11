DESCRIPTION = "Image Selector"

DEPENDS += "bootgen-native"
RCONFLICTS:${PN} = "image-selector"

inherit check_xsct_enabled xsctapp xsctyaml deploy

PARALLEL_MAKE = "-j 1"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:zynqmp = "zynqmp"

XSCTH_APP:zynqmp = "Image Selector"

do_configure:append () {
	# Required for SOM only
	sed -i "s|//#define XIS_UPDATE_A_B_MECHANISM|#define XIS_UPDATE_A_B_MECHANISM|g" ${B}/${XSCTH_PROJ}/xis_config.h
	sed -i "s|#define XIS_GET_BOARD_PARAMS|//#define XIS_GET_BOARD_PARAMS|g" ${B}/${XSCTH_PROJ}/xis_config.h

cat > ${WORKDIR}/${PN}.bif << EOF
        the_ROM_image:
        {
                [bootloader,destination_cpu=a53-0] ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE}
        }
EOF
}

do_compile:append () {
        bootgen -image ${WORKDIR}/${PN}.bif -arch ${SOC_FAMILY} -w -o ${B}/${XSCTH_PROJ}/${PN}.bin

        printf "* ${PN}\nSRCREV: ${SRCREV}\nBRANCH: ${BRANCH}\n\n" > ${S}/${PN}.manifest
}

do_deploy:append () {
        install -Dm 0644 ${B}/${XSCTH_PROJ}/${PN}.bin ${DEPLOYDIR}/image-selector.bin
        ln -sf image-selector.bin ${DEPLOYDIR}/image-selector-${MACHINE}.bin

        install -Dm 0644 ${S}/${PN}.manifest ${DEPLOYDIR}/image-selector-${MACHINE}.manifest
}
