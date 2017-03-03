DESCRIPTION = "Recipe to copy externally built HDF to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "git://"
HDF_PATH ?= "gitenterprise.xilinx.com/Yocto/hdf-examples.git"
HDF_NAME ?= "system.hdf"

SRC_URI = "${HDF_BASE}${HDF_PATH}"

SRCREV ?= "dc9f149c84bc68da92a512b3b711caf6b02d4841"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    if [ "${HDF_BASE}" = "git://" ]; then
        install -m 0644 ${WORKDIR}/git/${MACHINE}/${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.hdf
    else
        install -m 0644 ${WORKDIR}/${HDF_PATH} ${DEPLOYDIR}/Xilinx-${MACHINE}.hdf
    fi
}
addtask do_deploy after do_install
