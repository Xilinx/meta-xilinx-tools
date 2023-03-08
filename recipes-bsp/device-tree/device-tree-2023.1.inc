BRANCH = "xlnx_rel_v2023.1"
SRCREV = "ea2774cabb1a8abeba895d266d07586b37eb9b3e"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
