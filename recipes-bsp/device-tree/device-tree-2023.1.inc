BRANCH = "master"
SRCREV = "d02e5249648239955327cf221a2f9409d20f84eb"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
