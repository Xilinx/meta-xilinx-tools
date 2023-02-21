BRANCH = "master"
SRCREV = "9cab12d5284acc97b4d31b8291da38ad6df467a3"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
