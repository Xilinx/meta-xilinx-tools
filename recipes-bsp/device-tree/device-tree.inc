REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI:append = " ${REPO};${BRANCHARG}"

XILINX_RELEASE_VERION ??= "v2024.1"
XILINX_XSCT_VERSION ??= "${@d.getVar("XILINX_RELEASE_VERSION").replace('v','')}"

require device-tree-${XILINX_XSCT_VERSION}.inc
