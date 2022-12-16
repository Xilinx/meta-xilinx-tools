BRANCH = "master"
SRCREV = "56ec2ff81e27ccd76199148616552c02a85f4e5e"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
