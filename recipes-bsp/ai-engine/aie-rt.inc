SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/aie-rt.git;protocol=https"

BRANCH ?= "main-aie"
SRCREV ?= "bdb71ae12b2883fc2eb7f1cb594c316feb7e2404"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM ?= "file://license.txt;md5=b81abf1f508952331dd7d2ab36408f5b"

SRC_URI = "${REPO};branch=${BRANCH}"
