SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "master-rel-2020.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "08b9f4304d1634ed632f4276d603d834940fd55a"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=3a6e22aebf6516f0f74a82e1183f74f8"

SRC_URI = "${REPO};${BRANCHARG}"
