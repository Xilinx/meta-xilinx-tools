BRANCH = "master"
SRCREV = "e05d0d4b3d119ac459602a8d5d0422e8bc78f754"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
