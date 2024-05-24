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
        # In Segmented Configuration design vivado tools will generate both
        # "_boot" and "_pld.pdi" embedded in single xsa and Hence use *_boot.pdi
        # packaged to Boot.bin.
        if [ -f ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*_boot.pdi ]; then
            install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*_boot.pdi ${D}/boot/base-design.pdi
        else
            bbfatal "Multiple PDI found in xsa, Use BASE_PDI_NAME to pick from the following:\n$(basename -a ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.pdi)"
        fi
    else
        bbfatal "No pdi found in xsa"
    fi
}
