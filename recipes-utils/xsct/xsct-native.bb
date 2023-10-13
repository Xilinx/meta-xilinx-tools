SUMMARY = "Trigger XSCT to download and install"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INHIBIT_DEFAULT_DEPS = "1"

inherit native

# If the user called us, lets attempt to do "nothing" to trigger the download/verification event
BB_DONT_CACHE = '1'

do_fetch[noexec] = "1"
do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install[noexec] = "1"
do_deploy[noexec] = "1"
