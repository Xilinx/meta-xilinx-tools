BRANCH = "master"
SRCREV = "8b48ee895254eb14c802dc050b5c362e3c81bb92"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
