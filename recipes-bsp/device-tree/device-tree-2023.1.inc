BRANCH = "master"
SRCREV = "1aae2a33465cd4eaa76c1260052ec5fd7c142ff8"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
