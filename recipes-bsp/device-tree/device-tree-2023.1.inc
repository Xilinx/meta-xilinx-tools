BRANCH = "master"
SRCREV = "6a88e429c8ea9890fe8986d0a13f7bbbfe078cd4"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
