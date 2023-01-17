BRANCH = "master"
SRCREV = "8c3aa6195d585e10f6de597974b18a7813ce3231"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
