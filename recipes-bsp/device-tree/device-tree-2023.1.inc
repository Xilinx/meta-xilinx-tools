BRANCH = "master"
SRCREV = "8291ab0c59fd6e809f2dbbce64471f0b300cda1b"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
