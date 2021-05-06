SECTION	= "libs"

require conf/embeddedsw.inc

LICENSE = "BSD"

BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI = "${REPO};${BRANCHARG}"
