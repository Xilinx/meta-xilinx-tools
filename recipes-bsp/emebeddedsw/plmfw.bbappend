inherit bootbin-component

# This lets plmfw be build completely within a Linux build
PLM_DEPENDS ?= "plm-firmware:do_deploy"
PLM_MCDEPENDS ?= ""
PLM_FILE ?= "${DEPLOY_DIR_IMAGE}/plm-firmware-${MACHINE}.elf"
