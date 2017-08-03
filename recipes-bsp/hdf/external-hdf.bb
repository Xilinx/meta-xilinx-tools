DESCRIPTION = "Recipe to copy externally built HDF to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "git://"
HDF_PATH ?= "github.com/Xilinx/hdf-examples.git"
HDF_NAME ?= "system.hdf"

SRC_URI = "${HDF_BASE}${HDF_PATH}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

SRCREV ?= "97bf3d57bf53662ba42121b044b56b3ab6e0ff21"
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
