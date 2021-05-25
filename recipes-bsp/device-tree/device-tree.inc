REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI_append = " ${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.1"
SRCREV = "70414dce452abe0e42628c656419dbac71913387"


