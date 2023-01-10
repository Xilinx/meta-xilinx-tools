BRANCH = "master"
SRCREV = "919b2ccac915ae1930b687f012040673c2b525aa"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
