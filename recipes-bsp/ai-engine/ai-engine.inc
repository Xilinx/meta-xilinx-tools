SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2019.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRCREV ?= "5eca1eabf09965015bbca5f9888a01aac47c680c"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=cdeb576635c5f585881bc24b1339765f"

SRC_URI = "${REPO};${BRANCHARG}"

AIEDIR = "${S}/XilinxProcessorIPLib/drivers/aiengine"
S = "${WORKDIR}/git"
I = "${AIEDIR}/include"
