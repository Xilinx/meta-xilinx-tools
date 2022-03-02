REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI:append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2022.1"
SRCREV = "6a24e0f62edb2438e82aaee8ede18c042a95b26e"

