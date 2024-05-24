# Whent his layer is included, we hard code how to build the firmware
FSBL_DEPENDS = "${@bb.utils.contains('BBMULTICONFIG', 'fsbl-fw', '', 'fsbl-firmware:do_deploy', d)}"
FSBL_MCDEPENDS = "${@bb.utils.contains('BBMULTICONFIG', 'fsbl-fw', 'mc::fsbl-fw:fsbl-firmware:do_deploy', '', d)}"
FSBL_DEPLOY_DIR = "${@bb.utils.contains('BBMULTICONFIG', 'fsbl-fw', '${TOPDIR}/tmp-fsbl-fw/deploy/images/${MACHINE}', '${DEPLOY_DIR_IMAGE}', d)}"

# This needs to match the value in fsbl-firmware.bbappend
FSBL_IMAGE_NAME = "fsbl-${MACHINE}"

# We can skip the check, as we will build this
def check_pmu_vars(d):
   return
