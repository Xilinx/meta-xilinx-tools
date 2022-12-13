BRANCH = "xlnx_rel_v2022.2"
SRCREV = "24d29888d0048f26e4f3d6e0b7cd655aede94f31"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2022.2:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"
