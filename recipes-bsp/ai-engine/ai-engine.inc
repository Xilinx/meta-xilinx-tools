SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/embeddedsw.git;protocol=https"
BRANCH ?= "master-rel-2020.2"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRCREV ?= "ab200970da5333d4287b128c9ccd78786fb2ebab"

LICENSE = "BSD"
LIC_FILES_CHKSUM="file://license.txt;md5=64f55aaa4b1bbdab348c0703190d558a"

SRC_URI = "${REPO};${BRANCHARG}"
