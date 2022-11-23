BRANCH = "master"
SRCREV = "c98f13d4d8e74dc0c589865dee1ac5e65c56c0bc"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
