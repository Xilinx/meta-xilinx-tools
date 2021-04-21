python __anonymous () {
    #check if there are any dtb providers
    providerdtb = d.getVar("PREFERRED_PROVIDER_virtual/dtb")
    if providerdtb:
       d.appendVarFlag('do_configure', 'depends', ' virtual/dtb:do_populate_sysroot')
       if d.getVar("DTB_NAME") is not None:
            d.setVar('DTB_NAME', d.getVar('BASE_DTS')+ '.dtb')
}
BASE_DTS ?= "system-top"
DTB_PATH ?= "/boot/devicetree"
DTB_NAME ?= ""

EXTRA_OEMAKE += "${@'EXT_DTB=${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME}' if (d.getVar('DTB_NAME') != '') else '' }"

UBOOTELF_NODTB_IMAGE ?= "u-boot-nodtb.elf"
UBOOTELF_NODTB_BINARY ?= "u-boot"
do_deploy_prepend() {
    cd ${B}

    if [ -f "${UBOOTELF_NODTB_BINARY}" ]; then
            install ${UBOOTELF_NODTB_BINARY} ${DEPLOYDIR}/${UBOOTELF_NODTB_IMAGE}
    fi

    #following lines are from uboot-sign.bbclass, vars are defined there
    if [ -e "${UBOOT_DTB_BINARY}" ]; then
            ln -sf ${UBOOT_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_DTB_BINARY}
            ln -sf ${UBOOT_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_DTB_SYMLINK}
    fi
    if [ -f "${UBOOT_NODTB_BINARY}" ]; then
            install ${UBOOT_NODTB_BINARY} ${DEPLOYDIR}/${UBOOT_NODTB_IMAGE}
            ln -sf ${UBOOT_NODTB_IMAGE} ${DEPLOYDIR}/${UBOOT_NODTB_SYMLINK}
            ln -sf ${UBOOT_NODTB_IMAGE} ${DEPLOYDIR}/${UBOOT_NODTB_BINARY}
    fi
}
