DESCRIPTION = "Recipe to copy and install externally built XSA to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

INHIBIT_DEFAULT_DEPS = "1"

inherit check_xsct_enabled deploy image-artifact-names

# The user is expected to define HDF_URI, and HDF_URI[sha256sum].  Optionally
# they may also define HDF_URI[S] to define the unpacking path.
HDF_URI[doc] = "URI for the .xsa file, set by the machine configuration file"

HDF_URI ??= ""

SRC_URI = "${HDF_URI}"
SRC_URI[sha256sum] = "${@d.getVarFlag('HDF_URI', 'sha256sum') or 'undefined'}"

# Define a default, but allow a machine.conf to override if needed
HDF_NAME ?= "${@os.path.basename(d.getVar('HDF_URI') or '')}"
HDF_BASE_NAME = "${@os.path.basename(d.getVar('HDF_NAME') or '').replace('.xsa', '')}"

COMPATIBLE_HOST:xilinx-standalone = "${HOST_SYS}"
PACKAGE_ARCH ?= "${MACHINE_ARCH}"

def findS(d):
    url = d.getVar('HDF_URI')
    s = d.getVarFlag('HDF_URI', 'S')
    if not s:
        if url.startswith('file:///'):
            s = '${WORKDIR}' + os.path.dirname(url[7:])
        else:
            s = '${WORKDIR}'
    return s

# Don't set S = "${WORKDIR}/git" as we need this to work for other protocols
S = "${@findS(d) or '${WORKDIR}'}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install[noexec] = "1"

python () {
    if (d.getVar('XILINX_WITH_ESW') != 'xsct'):
        raise bb.parse.SkipRecipe("This recipe is only supported in xsct workflow.")

    if (d.getVar('XILINX_XSCT_VERSION') != d.getVar('PV')):
        raise bb.parse.SkipRecipe("Only xsct version %s is supported." % d.getVar('XILINX_XSCT_VERSION'))

    if (not d.getVar('HDF_URI')):
        raise bb.parse.SkipRecipe("HDF_URI must be specified.  See recipe for instructions.")

    if (not d.getVar('HDF_URI').startswith('file://')) and (not d.getVarFlag('HDF_URI', 'sha256sum')):
        raise bb.parse.SkipRecipe("HDF_URI[sha256sum] must be specified for remove HDF_URI.  See recipe for instructions.")
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${HDF_NAME} ${DEPLOYDIR}/${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.xsa
    if [ ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.xsa != ${MACHINE}${IMAGE_VERSION_SUFFIX}.xsa ]; then
        ln -s ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.xsa ${DEPLOYDIR}/${MACHINE}${IMAGE_VERSION_SUFFIX}.xsa
    fi
    ln -s ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.xsa ${DEPLOYDIR}/Xilinx-${MACHINE}${IMAGE_VERSION_SUFFIX}.xsa
    ln -s ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.xsa ${DEPLOYDIR}/Xilinx-${MACHINE}.xsa
}

addtask deploy after do_install before do_build
