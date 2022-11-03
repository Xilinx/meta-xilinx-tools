BRANCH = "xlnx_rel_v2022.2"
SRCREV = "24d29888d0048f26e4f3d6e0b7cd655aede94f31"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2022.2:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
