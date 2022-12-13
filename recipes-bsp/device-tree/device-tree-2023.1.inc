BRANCH = "master"
SRCREV = "6271025f43f622f9fd75c046f462ee45e6c8963a"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
