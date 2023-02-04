BRANCH = "master"
SRCREV = "bdde0a5712d32a3c3a8c1a7535700fb7d7ea8f1a"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
