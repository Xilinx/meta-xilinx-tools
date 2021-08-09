REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI_append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.2"
SRCREV = "9bec3ec1b7d58ba735ae0a8f4d1e5f63c3c9ba7a"

