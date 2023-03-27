BRANCH = "xlnx_rel_v2023.1"
SRCREV = "01ee865fdcb898c7f4725d62196d08c2a96a059c"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
