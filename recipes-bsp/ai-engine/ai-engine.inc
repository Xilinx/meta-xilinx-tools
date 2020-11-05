SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "master-rel-2020.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "3a6e22aebf6516f0f74a82e1183f74f8"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=64f55aaa4b1bbdab348c0703190d558a"

SRC_URI = "${REPO};${BRANCHARG}"
