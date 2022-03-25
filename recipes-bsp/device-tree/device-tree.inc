REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI:append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2022.1"
SRCREV = "cbd7b1f4f995903f7642ca8339991c4d55536735"

