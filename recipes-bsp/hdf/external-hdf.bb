DESCRIPTION = "Recipe to copy and install externally built XSA to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "git://"
HDF_PATH ??= "github.com/xilinx/hdf-examples.git"
HDF_NAME ?= "system.xsa"

HDF_EXT ?= "xsa"

SRC_URI = "${HDF_BASE}${HDF_PATH}"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

SRCREV ??= "612922be08cbabce5918d186ebc2147891d0ef9c"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile[noexec] = "1"


python do_check() {
    ext=d.getVar('HDF_EXT',True)
    if(ext == 'hdf'):
         bb.fatal("Only XSA is supported from release 2019.2")
}


do_install() {
    install -d ${D}/opt/xilinx/hw-design
    if [ "${HDF_BASE}" = "git://" ]; then
         install -m 0644 ${S}/${MACHINE}/${HDF_NAME} ${D}/opt/xilinx/hw-design/design.xsa
    else
         install -m 0644 ${WORKDIR}/${HDF_PATH} ${D}/opt/xilinx/hw-design/design.xsa
    fi
}

do_deploy() {
    install -d ${DEPLOYDIR}
    if [ "${HDF_BASE}" = "git://" ]; then
        install -m 0644 ${WORKDIR}/git/${MACHINE}/${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
    else
        install -m 0644 ${WORKDIR}/${HDF_PATH} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
    fi
}

addtask do_check before do_deploy
addtask do_deploy after do_install
FILES_${PN}= "/opt/xilinx/hw-design/design.xsa"
SYSROOT_DIRS += "/opt"

