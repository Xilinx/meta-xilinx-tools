SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2020.2.2_k26"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "6d507ed8c006d8090aec8c10e24ef34706920884"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=64e026e5fcf32dffb500cb265cf57fe1"

SRC_URI = "${REPO};${BRANCHARG}"
