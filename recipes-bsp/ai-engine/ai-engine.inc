SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "master-rel-2019.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRCREV ?= "8d07f71a1ec1e9823e12da64b2806eff97d51985"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=cdeb576635c5f585881bc24b1339765f"

SRC_URI = "${REPO};${BRANCHARG}"

AIEDIR = "${S}/XilinxProcessorIPLib/drivers/aiengine"
S = "${WORKDIR}/git"
I = "${AIEDIR}/include"
