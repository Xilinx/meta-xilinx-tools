SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2020.3"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "68ced7ee3b4197830c1266b3973654c7952f0af7"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=a3e150f71d508f8ce31ecd0daf5e1abc"

SRC_URI = "${REPO};${BRANCHARG}"
