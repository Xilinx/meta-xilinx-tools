REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI_append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.1"
SRCREV = "497e9a5180f2d2a5471018b1004fb238f5379e86"


