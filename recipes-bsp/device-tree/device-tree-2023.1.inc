BRANCH = "master"
SRCREV = "ff91cfa06f8b31b6b5c7fd3262dbf764e92218e9"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
