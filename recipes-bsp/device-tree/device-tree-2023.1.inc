BRANCH = "master"
SRCREV = "2689f382f1d140c0255ce470b3116295fab05f56"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
