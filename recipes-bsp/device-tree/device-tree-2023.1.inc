BRANCH = "master"
SRCREV = "216735aae0ff123ed6872fa0b1d952ef9c5f96aa"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
