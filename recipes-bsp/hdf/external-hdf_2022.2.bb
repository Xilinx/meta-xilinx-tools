DESCRIPTION = "Recipe to copy and install externally built XSA to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

INHIBIT_DEFAULT_DEPS = "1"

inherit check_xsct_enabled deploy image-artifact-names

HDF_MACHINE ?= "${MACHINE}"

# HDF_BASE - file protocol
# HDF_PATH - Path to git repository, or file in question
# HDF_NAME - Path to the XSA file once downloaded (must be inside WORKDIR) (See anon python)
HDF_BASE ??= "git://"
HDF_PATH ??= "github.com/Xilinx/hdf-examples.git"
HDF_NAME ??= ""

BRANCH ??= "xlnx_rel_v2022.2"
SRCREV ??= "ffb2ad9fb8f6e08ef579b03845c00f189db69999"
BRANCHARG ??= "${@['', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
BRANCHARGS = "${@['', ';${BRANCHARG}'][d.getVar('BRANCHARG', True) != '']}"

# Only 'xsa' is currently supported here
HDF_EXT ?= "xsa"

# Provide a way to extend the SRC_URI, default to adding protocol=https for git:// usage.
HDF_EXTENSION ?= "${@';protocol=https' if d.getVar('HDF_BASE') == 'git://' else ''}"

# HDF_NAME without the .xsa
HDF_BASE_NAME = "${@os.path.basename(d.getVar('HDF_NAME') or '').replace('.xsa', '')}"

SRC_URI = "${HDF_BASE}${HDF_PATH}${BRANCHARGS}${HDF_EXTENSION}"

# Above is the last change fallback.  The include file, if it exists, is the current xsa files
include hdf-repository.inc

COMPATIBLE_HOST:xilinx-standalone = "${HOST_SYS}"
PACKAGE_ARCH ?= "${MACHINE_ARCH}"

# Don't set S = "${WORKDIR}/git" as we need this to work for other protocols
# HDF_NAME will be adjusted to include /git if needed
S = "${WORKDIR}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install[noexec] = "1"

python () {
    if (d.getVar('XILINX_WITH_ESW') != 'xsct'):
        raise bb.parse.SkipRecipe("This recipe is only supported in xsct workflow.")

    if (d.getVar('XILINX_XSCT_VERSION') != d.getVar('PV')):
        raise bb.parse.SkipRecipe("Only xsct version %s is supported." % d.getVar('XILINX_XSCT_VERSION'))

    if (d.getVar('HDF_EXT') != 'xsa'):
        raise bb.parse.SkipRecipe("Only XSA format is supported in Vivado tool starting from 2019.2 release")

    if (not d.getVar("HDF_NAME")):
        if d.getVar('HDF_BASE') == 'git://':
            # git:// default to ${HDF_MACHINE}/system.xsa
            hdf_name = '${S}/git/${HDF_MACHINE}/system.xsa'
        elif d.getVar('HDF_BASE') == 'file://':
            # file:// default to the full path
            hdf_name = "${S}/${HDF_PATH}"
        else:
            # Look for the downloadfilename and user it if defined
            # the key is that HDF_MACHINE is the name= field.
            hdf_filename = os.path.basename(d.getVar('HDF_PATH'))
            for url in d.getVar('SRC_URI').split():
                filename = hdf_filename
                done = False
                for chunk in url.split(';'):
                    if chunk.startswith('downloadfilename='):
                        filename=chunk[17:]
                        continue
                    if chunk.startswith('name='):
                        if chunk[5:] == d.getVar('HDF_MACHINE'):
                            done = True
                if done:
                    hdf_filename = filename
                    break

            # Everyone else default to the basename of the HDF_PATH
            hdf_name = "${S}/%s" % hdf_filename

        d.setVar('HDF_NAME', hdf_name)

    # Must be in S, this ensures that the build environment is aware of the file for checksuming
    # set HDF_BASE = "file://" and HDF_PATH to the local disk path instead
    if not d.getVar('HDF_NAME').startswith(d.getVar('S')):
        raise bb.parse.SkipRecipe("HDF_NAME must be in the S directory, did you mean to set HDF_PATH instead?")
}

do_check() {
    if [ ! -f ${HDF_NAME} ]; then
        bbfatal "Unable to find ${HDF_NAME}.  Verify HDF_BASE, HDF_PATH and HDF_NAME."
    fi
}

do_install[noexec] = "1"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${HDF_NAME} ${DEPLOYDIR}/${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.${HDF_EXT}
    if [ ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.${HDF_EXT} != ${MACHINE}${IMAGE_VERSION_SUFFIX}.${HDF_EXT} ]; then
        ln -s ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.${HDF_EXT} ${DEPLOYDIR}/${MACHINE}${IMAGE_VERSION_SUFFIX}.${HDF_EXT}
    fi
    ln -s ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.${HDF_EXT} ${DEPLOYDIR}/Xilinx-${MACHINE}${IMAGE_VERSION_SUFFIX}.${HDF_EXT}
    ln -s ${HDF_BASE_NAME}${IMAGE_VERSION_SUFFIX}.${HDF_EXT} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}

}

addtask check before do_deploy after do_patch
addtask deploy after do_install before do_build
