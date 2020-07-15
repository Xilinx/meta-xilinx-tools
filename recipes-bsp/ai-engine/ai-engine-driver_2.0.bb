SUMMARY = "Xilinx AI Engine runtime"
DESCRIPTION = "This library provides APIs for the runtime support of the Xilinx AI Engine IP"

SECTION	= "libs"

REPO ?= "git://gitenterprise.xilinx.com/embeddedsw/aienginev2.git;protocol=https"
BRANCH ?= "master"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "${AUTOREV}"

LICENSE = "MIT"
LIC_FILES_CHKSUM="file://license.txt;md5=f5b04e905dfe6ab50aa69bcc488f88fa"

SRC_URI = "${REPO};${BRANCHARG}"

AIEDIR = "${S}"
S = "${WORKDIR}/git"
I = "${AIEDIR}/include"

# Keep v1 as default for now.
DEFAULT_PREFERENCE = "-1"

DEPENDS = "libmetal"
RDEPENDS_${PN} = "libmetal"
PROVIDES = "libxaiengine"
RPROVIDES_${PN}	= "libxaiengine"

# The makefile isn't ready for parallel execution at the moment
PARALLEL_MAKE = "-j 1"

EXTRA_OEMAKE = "-C ${AIEDIR}/src -f Makefile.Linux"

do_compile(){
	oe_runmake
}

do_install(){
	install -d ${D}${includedir}
	install ${I}/*.h ${D}${includedir}/
	install -d ${D}${includedir}/xaiengine
	install ${I}/xaiengine/*.h ${D}${includedir}/xaiengine/
	install -d ${D}${libdir}
	cp -dr ${AIEDIR}/src/*.so* ${D}${libdir}
}
