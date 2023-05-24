DESCRIPTION = "Recipe to copy and install externally built XSA to deploy"

LICENSE = "CLOSED"

PROVIDES = "virtual/hdf"

INHIBIT_DEFAULT_DEPS = "1"

inherit deploy

HDF_BASE ??= ""
HDF_BASE[doc] = "Download protocol (file://, git://, http:// or https://)"
HDF_PATH ??= ""
HDF_PATH[doc] = "Path to git repository, or file"
HDF_NAME ??= ""
HDF_NAME[doc] = "Path to the XSA file once downloaded, usually set by the recipe (must be inside WORKDIR) (See anon python)"

BRANCH ??= ""
SRCREV ??= ""
BRANCHARG ??= "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"

# For example (git repository):
#  HDF_BASE = "git://"
#  HDF_PATH = "github.com/Xilinx/hdf-examples.git"
#  HDF_NAME = ""
#  BRANCH   = "master"
#  SRCREV   = "289816af3b6c4fa651a347e6c9f22f76f45dee97"
# The recipe will clone git://github.com/Xilinx/hdf-examples.git, it will then
# look in the subdirectory specified by "${HDF_MACHINE}", for system.xsa
#
# Example (git repository):
#  HDF_BASE = "git://"
#  HDF_PATH = "github.com/Xilinx/hdf-examples.git"
#  HDF_NAME = "${S}/git/my_example.xsa"
#  BRANCH   = "master"
#  SRCREV   = "289816af3b6c4fa651a347e6c9f22f76f45dee97"
# The recipe will clone the git repository, then look for 'my_example.xsa'
# in the root of the cloned directory
#
# Example (local file):
#  HDF_BASE = "file://"
#  HDF_PATH = "${TOPDIR}/conf/my_example.xsa
# The recipe will use the XSA from ${TOPDIR}/conf/my_example.xsa
#
# Example (http or https):
#  HDF_BASE = "https://"
#  HDF_PATH = "example.com/my-custom-board/my-custom-board.xsa"

# Only 'xsa' is currently supported here
HDF_EXT ?= "xsa"

# Provide a way to extend the SRC_URI, default to adding protocol=https for git:// usage.
HDF_EXTENSION ?= "${@';protocol=https' if d.getVar('HDF_BASE') == 'git://' else ''}"

SRC_URI = "${HDF_BASE}${HDF_PATH};${BRANCHARG}${HDF_EXTENSION}"

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
    if (d.getVar('HDF_EXT') != 'xsa'):
        raise bb.parse.SkipRecipe("Only XSA format is supported in Vivado tool starting from 2019.2 release")

    if (not d.getVar('HDF_BASE') or not d.getVar('HDF_PATH')):
        raise bb.parse.SkipRecipe("HDF_BASE and HDF_PATH must be specified.  See recipe for instructions.")

    if (not d.getVar("HDF_NAME")):
        if d.getVar('HDF_BASE') == 'git://':
            # git:// default to ${HDF_MACHINE}/system.xsa
            hdf_name = '${S}/git/${HDF_MACHINE}/system.xsa'
        elif d.getVar('HDF_BASE') == 'file://':
            # file:// default to the full path
            hdf_name = "${S}/${HDF_PATH}"
        else:
            # Look for the downloadfilename and use it if defined
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

HDF_MACHINE ?= "${MACHINE}"

do_install() {
    install -d ${D}/opt/xilinx/hw-design
    install -m 0644 ${HDF_NAME} ${D}/opt/xilinx/hw-design/design.${HDF_EXT}
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${HDF_NAME} ${DEPLOYDIR}/Xilinx-${MACHINE}.${HDF_EXT}
}

addtask do_check before do_deploy after do_patch
addtask do_deploy after do_install

PACKAGES = ""
FILES:${PN}= "/opt/xilinx/hw-design/design.${HDF_EXT}"
SYSROOT_DIRS += "/opt"
