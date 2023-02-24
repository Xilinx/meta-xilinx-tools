BRANCH = "master"
SRCREV = "356c018c1e9f586e06d2c134c617c92ab7f18b7e"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
