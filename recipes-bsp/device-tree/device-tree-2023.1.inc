BRANCH = "master"
SRCREV = "793852244110a3872549fcdaee86c36783a69e61"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
