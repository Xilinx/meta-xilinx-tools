BRANCH = "master"
SRCREV = "052bb77074c7449afd08353e11a538348c6e1341"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
