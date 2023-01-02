BRANCH = "master"
SRCREV = "9e7e0939b7273780fd9e1140bf90093a20f87da7"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
