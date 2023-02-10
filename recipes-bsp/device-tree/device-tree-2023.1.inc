BRANCH = "master"
SRCREV = "a55cce7cad3357a560d24e3cd49a250568903d3d"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
