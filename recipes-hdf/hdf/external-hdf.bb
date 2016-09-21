DESCRIPTION = "Recipe to copy externally built HDF to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "file://"
HDF_PATH ?= ""

SRC_URI = "${HDF_BASE}/${HDF_PATH}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install() {
    install -d ${DEPLOY_DIR_IMAGE}
    install -m 0644 ${WORKDIR}/${HDF_PATH} ${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.hdf
}
