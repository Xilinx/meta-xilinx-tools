# Whent his layer is included, we hard code how to build the firmware
PSM_DEPENDS = "${@bb.utils.contains('BBMULTICONFIG', 'versal-fw', '', 'psm-firmware:do_deploy', d)}"
PSM_MCDEPENDS = "${@bb.utils.contains('BBMULTICONFIG', 'versal-fw', 'mc::versal-fw:psm-firmware:do_deploy', '', d)}"
PSM_FIRMWARE_DEPLOY_DIR = "${@bb.utils.contains('BBMULTICONFIG', 'versal-fw', '${TOPDIR}/tmp-microblaze-versal-fw/deploy/images/${MACHINE}', '${DEPLOY_DIR_IMAGE}', d)}"

# This needs to match the value in psm-firmware.bbappend
PSM_FIRMWARE_IMAGE_NAME = "psm-firmware-${MACHINE}"

# We can skip the check, as we will build this
def check_psm_vars(d):
   return
