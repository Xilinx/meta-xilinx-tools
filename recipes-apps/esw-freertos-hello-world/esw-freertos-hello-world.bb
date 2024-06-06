SUMMARY = "Hello World FreeRTOS Application for RPU using XSCT"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit xsct_freertos_app

SRC_URI = "${EMBEDDEDSW_SRCURI}"
S = "${UNPACKDIR}/git"

# Set the template app to "Hello World"
XSCTH_APP = "FreeRTOS Hello World"

COMPATIBLE_MACHINE:zynqmp = ".*"
COMPATIBLE_MACHINE:versal = ".*"

PACKAGE_ARCH = "${MACHINE_ARCH}"
