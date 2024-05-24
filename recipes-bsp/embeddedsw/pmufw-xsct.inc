# Whent his layer is included, we hard code how to build the firmware
PMU_DEPENDS = "${@bb.utils.contains('BBMULTICONFIG', 'zynqmp-pmufw', '', 'pmu-firmware:do_deploy', d)}"
PMU_MCDEPENDS = "${@bb.utils.contains('BBMULTICONFIG', 'zynqmp-pmufw', 'mc::zynqmp-pmufw:pmu-firmware:do_deploy', '', d)}"
PMU_FIRMWARE_DEPLOY_DIR = "${@bb.utils.contains('BBMULTICONFIG', 'zynqmp-pmufw', '${TOPDIR}/tmp-microblaze-zynqmp-pmufw/deploy/images/${MACHINE}', '${DEPLOY_DIR_IMAGE}', d)}"

# This needs to match the value in pmu-firmware.bbappend
PMU_FIRMWARE_IMAGE_NAME = "pmu-firmware-${MACHINE}"

# We can skip the check, as we will build this
def check_pmu_vars(d):
   return
