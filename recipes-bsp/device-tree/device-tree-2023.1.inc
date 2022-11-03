BRANCH = "master"
SRCREV = "1e52c54fa921f98df17c21fcd09545a558a21422"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
