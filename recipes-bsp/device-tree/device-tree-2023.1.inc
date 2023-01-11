BRANCH = "master"
SRCREV = "7ecf60401f4cb763feda26ebaadca234ae06e749"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
