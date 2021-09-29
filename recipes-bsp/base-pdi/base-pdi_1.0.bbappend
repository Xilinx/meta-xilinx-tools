SRC_URI = ""

DEPENDS += "virtual/hdf"

HDF_EXT ?= "xsa"
PDI_HDF ?= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.${HDF_EXT}"

BASE_PDI_NAME ?= "project_1.pdi"

# We generate the PDI with XSCT, so don't verify the user provided one
PDI_SKIP_CHECK = '1'

inherit xsctbit

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj -hdf_type ${HDF_EXT}"

do_install() {
    install -d ${D}/boot

    if [ `ls ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.pdi | wc -l` -eq 1 ]; then

        install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.pdi ${D}/boot/base-design.pdi

    elif [ `ls ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.pdi | wc -l` -gt 1 ]; then

        if [ ! -f ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/${BASE_PDI_NAME} ]; then
            bbfatal "${BASE_PDI_NAME} is not a valid pdi name. Use BASE_PDI_NAME to pick from the following:\n$(basename -a ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.pdi)"
        fi
        install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/${BASE_PDI_NAME} ${D}/boot/base-design.pdi
    else
        bbfatal "No pdi exists in design"
    fi
}
