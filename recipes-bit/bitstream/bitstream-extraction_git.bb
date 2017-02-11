DESCRIPTION = "Recipe to extract bitstream"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

DEPENDS += "virtual/hdf"

PROVIDES = "virtual/bitstream"

inherit xsctbit deploy

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj"

do_compile[noexec] = "1"

do_deploy() {
        install -d ${DEPLOYDIR}
        if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
                install -m 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${DEPLOYDIR}/download-${MACHINE}.bit
        else
                touch ${DEPLOYDIR}/download-${MACHINE}.bit
        fi
}

addtask do_deploy after do_install
