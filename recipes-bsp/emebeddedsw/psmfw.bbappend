inherit bootbin-component

# This lets psmfw be build completely within a Linux build
PSM_DEPENDS ?= "psm-firmware:do_deploy"
PSM_MCDEPENDS ?= " "
PSM_FILE ?= "${DEPLOY_DIR_IMAGE}/psm-firmware-${MACHINE}.elf"
