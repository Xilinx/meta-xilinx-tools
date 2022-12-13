BRANCH = "xlnx_rel_v2022.1"
SRCREV = "1b364a44fae80fed4ea2863accc71f380b46c038"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2022.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"
