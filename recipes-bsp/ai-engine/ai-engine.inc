SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "master-rel-2020.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "df5ef17fb29640e830d954be9dae3710843df157"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=3a6e22aebf6516f0f74a82e1183f74f8"

SRC_URI = "${REPO};${BRANCHARG}"
