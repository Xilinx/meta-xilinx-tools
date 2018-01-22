DESCRIPTION = "Recipe to copy externally built HDF to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "git://"
HDF_PATH ?= "github.com/Xilinx/hdf-examples.git"
HDF_NAME ?= "system.hdf"

SRC_URI = "${HDF_BASE}${HDF_PATH}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

SRCREV ?= "01ad8ea5fd1989abf4ea5a072d019a16cb2bc546"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    if [ "${HDF_BASE}" = "git://" ]; then
        install -m 0644 ${WORKDIR}/git/${MACHINE}/${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.hdf
    else
        install -m 0644 ${WORKDIR}/${HDF_PATH}/${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.hdf
    fi
}
addtask do_deploy after do_install
