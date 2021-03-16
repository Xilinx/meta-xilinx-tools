SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "release-2020.3"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "d3a68e32d4a57608a3d5bb1106b6ec702621bdb6"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=a3e150f71d508f8ce31ecd0daf5e1abc"

SRC_URI = "${REPO};${BRANCHARG}"
