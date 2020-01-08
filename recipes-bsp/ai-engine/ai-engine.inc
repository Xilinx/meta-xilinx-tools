SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2019.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "e8db5fb118229fdc621e0ec7848641a23bf60998"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=39ab6ab638f4d1836ba994ec6852de94"

SRC_URI = "${REPO};${BRANCHARG}"

AIEDIR = "${S}/XilinxProcessorIPLib/drivers/aiengine"
S = "${WORKDIR}/git"
I = "${AIEDIR}/include"
