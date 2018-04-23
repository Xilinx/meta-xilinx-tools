DEPENDS += "virtual/dtb"

DTB_PATH ?= "/boot/devicetree"
DTB_NAME ?= "system-top.dtb"

EXTRA_OEMAKE += "${@'EXT_DTB=${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME}' if (d.getVar('DTB_NAME', True) != '') else '' }"
