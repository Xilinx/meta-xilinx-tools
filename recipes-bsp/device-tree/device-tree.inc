REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI_append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.2"
SRCREV = "633113dd46b3f44ae39ecc67c5157784eb82cbb1"

