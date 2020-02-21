inherit bootbin-component

python __anonymous () {
    #check if there are any dtb providers
    providerdtb = d.getVar("PREFERRED_PROVIDER_virtual/dtb")
    if providerdtb:
       d.appendVarFlag('do_configure', 'depends', ' virtual/dtb:do_populate_sysroot')
       if d.getVar("DTB_NAME") is not None:
           d.setVar('DTB_NAME', 'system-top.dtb')
}

DTB_PATH ?= "/boot/devicetree"
DTB_NAME ?= ""

BOOTBIN_BIF_FRAGMENT_zynqmp = "destination_cpu=a53-0,exception_level=el-2"

UBOOT_ELF_IMAGE = "${PN}-${SRCPV}.${UBOOT_ELF_SUFFIX}"

EXTRA_OEMAKE += "${@'EXT_DTB=${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME}' if (d.getVar('DTB_NAME') != '') else '' }"
