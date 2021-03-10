DESCRIPTION = "Recipe to copy and install externally built XSA to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

inherit deploy

HDF_BASE ?= "git://"
HDF_PATH ??= "github.com/xilinx/hdf-examples.git;branch=rel-v2020.3"
HDF_NAME ?= "system.xsa"

HDF_EXT ?= "xsa"

SRC_URI = "${HDF_BASE}${HDF_PATH}"

COMPATIBLE_HOST_xilinx-standalone = "${HOST_SYS}"
PACKAGE_ARCH ?= "${MACHINE_ARCH}"

SRCREV ??= "8ec0269c76de3b3fdf5865e176a3e3e6b2794213"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile[noexec] = "1"


python do_check() {
    ext=d.getVar('HDF_EXT')
    if(ext == 'hdf'):
         bb.warn("Only XSA format is supported in Vivado tool starting from 2019.2 release")
}


HDF_MACHINE ?= "${@d.getVar('BOARD') if d.getVar('BOARD') else d.getVar('MACHINE')}"

do_install() {
    install -d ${D}/opt/xilinx/hw-design
    if [ "${HDF_BASE}" = "git://" ]; then
         install -m 0644 ${S}/${HDF_MACHINE}/${HDF_NAME} ${D}/opt/xilinx/hw-design/design.xsa
    else
         install -m 0644 ${WORKDIR}/${HDF_PATH} ${D}/opt/xilinx/hw-design/design.xsa
    fi
}

do_deploy() {
    install -d ${DEPLOYDIR}
    if [ "${HDF_BASE}" = "git://" ]; then
        install -m 0644 ${WORKDIR}/git/${HDF_MACHINE}/${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
    else
        install -m 0644 ${WORKDIR}/${HDF_PATH} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
    fi
}

addtask do_check before do_deploy
addtask do_deploy after do_install
FILES_${PN}= "/opt/xilinx/hw-design/design.xsa"
SYSROOT_DIRS += "/opt"

