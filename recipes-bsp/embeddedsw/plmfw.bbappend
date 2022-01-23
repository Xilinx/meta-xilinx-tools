# Whent his layer is included, we hard code how to build the firmware
PLM_DEPENDS ?= "${@bb.utils.contains('BBMULTICONFIG', 'versal-fw', '', 'plm-firmware:do_deploy', d)}"
PLM_MCDEPENDS ?= "${@bb.utils.contains('BBMULTICONFIG', 'versal-fw', 'mc::versal-fw:plm-firmware:do_deploy', '', d)}"
PLM_DEPLOY_DIR ?= "${@bb.utils.contains('BBMULTICONFIG', 'versal-fw', '${TOPDIR}/tmp-microblaze-versal-fw/deploy/images/${MACHINE}', '${DEPLOY_DIR_IMAGE}', d)}"

# This needs to match the value in plm-firmware.bbappend
PLM_IMAGE_NAME = "plm-${MACHINE}"

# We can skip the check, as we will build this
def check_plm_vars(d):
   return
