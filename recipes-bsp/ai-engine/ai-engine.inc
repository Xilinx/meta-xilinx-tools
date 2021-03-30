SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2020.3"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "d12149e44651c1c429ee32322e250c3aff3edddf"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=a3e150f71d508f8ce31ecd0daf5e1abc"

SRC_URI = "${REPO};${BRANCHARG}"
