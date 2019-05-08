DESCRIPTION = "Recipe to copy externally built HDF to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "git://"
HDF_PATH ??= "github.com/xilinx/hdf-examples.git"
HDF_NAME ?= "system.hdf"
HDF_NAME_versal ?= "system.dsa"

#Set HDF_EXT to "dsa" if you want to use a dsa file instead of hdf.
HDF_EXT ?= "hdf"
HDF_EXT_versal ?= "dsa"

SRC_URI = "${HDF_BASE}${HDF_PATH}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

SRCREV ??= "612922be08cbabce5918d186ebc2147891d0ef9c"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    if [ "${HDF_BASE}" = "git://" ]; then
        install -m 0644 ${WORKDIR}/git/${MACHINE}/${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
    else
        install -m 0644 ${WORKDIR}/${HDF_PATH} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
    fi
}
addtask do_deploy after do_install
