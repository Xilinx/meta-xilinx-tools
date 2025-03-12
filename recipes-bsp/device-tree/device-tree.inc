REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI:append = " ${REPO};${BRANCHARG}"

XILINX_RELEASE_VERSION ??= "v2025.1"
XILINX_XSCT_VERSION ??= "${@d.getVar("XILINX_RELEASE_VERSION").replace('v','')}"

# Use the full path, so other layers can provide alternative versions
require recipes-bsp/device-tree/device-tree-${XILINX_XSCT_VERSION}.inc
