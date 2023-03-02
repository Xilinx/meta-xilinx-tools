BRANCH = "master"
SRCREV = "2122c181b1c9c3806c00e76a82fedceceff29d49"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
