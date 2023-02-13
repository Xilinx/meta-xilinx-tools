BRANCH = "master"
SRCREV = "df615aa33ba1c7bf5f93fc84b0a2e2cbbb088ac7"

FILESEXTRAPATHS:prepend := "${THISDIR}/files-2023.1:"
SRC_URI:append = " file://0001-zynqmp.dtsi-Change-mali400-interrupt-and-clock-names.patch"
