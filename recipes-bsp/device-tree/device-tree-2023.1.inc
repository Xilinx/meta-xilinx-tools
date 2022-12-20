BRANCH = "master"
SRCREV = "4cb5908374d1a2a38a7c68f6e41818a761ee9d45"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
