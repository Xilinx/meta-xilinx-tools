BRANCH = "master"
SRCREV = "b79c2919900c7f0d82cef633068bb07a306173a1"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
