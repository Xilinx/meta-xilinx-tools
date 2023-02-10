SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/aie-rt.git;protocol=https"

BRANCH ?= "main-aie"
SRCREV ?= "02600ad0d64ffb6c338165b9e3b4ada86cbc8b43"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM ?= "file://license.txt;md5=b81abf1f508952331dd7d2ab36408f5b"

SRC_URI = "${REPO};branch=${BRANCH}"
