REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI_append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.2"
SRCREV = "a3ca87a6d3b62069f09d7f054fd38590d738a198"

