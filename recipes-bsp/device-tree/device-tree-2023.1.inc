BRANCH = "master"
SRCREV = "d0f00cbf2c17136da79ac9a5ad6045f19bb16cbc"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
