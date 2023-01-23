BRANCH = "master"
SRCREV = "236f32b3b64e1932cb531dd624f37269775e6fff"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
