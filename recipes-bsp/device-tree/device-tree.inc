REPO ??= "git://github.com/Xilinx/device-tree-xlnx.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH') != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.1"
SRCREV = "12abbd90a2ce2430c29b2596c3a62822dea05900"


