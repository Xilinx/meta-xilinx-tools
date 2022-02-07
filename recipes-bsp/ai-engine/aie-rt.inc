SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/aie-rt.git;protocol=https"

BRANCH ?= "main-aie"
SRCREV ?= "7c361ae7f6d08feb497199566f344faa4f0c31f5"

LICENSE = "BSD"
LIC_FILES_CHKSUM ?= "file://license.txt;md5=4b22b8855ea10f84cb0e0a5f0a5ab2cb"

SRC_URI = "${REPO};branch=${BRANCH}"
