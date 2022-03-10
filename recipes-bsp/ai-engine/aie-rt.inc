SECTION	= "libs"

REPO ?= "git://github.com/Xilinx/aie-rt.git;protocol=https"

BRANCH ?= "xlnx_rel_v2022.1"
SRCREV ?= "405deec539feb0a9191743cc733a5304264fb8d8"

LICENSE = "BSD"
LIC_FILES_CHKSUM ?= "file://license.txt;md5=b81abf1f508952331dd7d2ab36408f5b"

SRC_URI = "${REPO};branch=${BRANCH}"
