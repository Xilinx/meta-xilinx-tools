SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/aie-rt.git;protocol=https"

BRANCH ?= "main-aie"
SRCREV ?= "65ec5b95b3be15786a1ea058706c31d38a2a8959"

LICENSE = "BSD"
LIC_FILES_CHKSUM ?= "file://license.txt;md5=4b22b8855ea10f84cb0e0a5f0a5ab2cb"

SRC_URI = "${REPO};branch=${BRANCH}"
