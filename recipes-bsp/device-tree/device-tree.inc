REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI:append = " ${REPO};${BRANCHARG}"

BRANCH = "master"
SRCREV = "2c440c168f8b4c16116859f0061a0e8c228cc5c5"

