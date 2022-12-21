BRANCH = "master"
SRCREV = "5d15229ef6e9b4eab4e44f00808ac792687e1732"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
