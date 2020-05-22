SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2020.1"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "6cbb920f4de9e650dc361b8e487f139fd4c3c743"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=8b565227e1264d677db8f841c2948cba"

SRC_URI = "${REPO};${BRANCHARG}"

AIEDIR = "${S}/XilinxProcessorIPLib/drivers/aiengine"
S = "${WORKDIR}/git"
I = "${AIEDIR}/include"
