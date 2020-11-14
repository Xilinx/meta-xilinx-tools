SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "master-rel-2020.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "08b9f4304d1634ed632f4276d603d834940fd55a"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=64f55aaa4b1bbdab348c0703190d558a"

SRC_URI = "${REPO};${BRANCHARG}"
