DT_RELEASE_VERSION = "2023.1"

BRANCH = "master"
SRCREV = "a28362aae205219d5c3ac6cd0540be3f1937a79b"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
