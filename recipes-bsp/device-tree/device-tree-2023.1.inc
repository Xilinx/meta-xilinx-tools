BRANCH = "master"
SRCREV = "21e0064536ff0394c2050139a2244b687c05239d"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
