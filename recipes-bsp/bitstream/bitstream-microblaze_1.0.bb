SUMMARY = "Generates download.bit using updatemem"
DESCRIPTION = "download.bit is a bitstream with an elf binary in it. \
This recipe will take a bitstream without any elf binary in it and add \
an elf file to it. By default fs-boot.elf is embedded into the bitstream, \
this can be overriding by setting DATA_FILE in your build environment"

LICENSE = "BSD-3-Clause"

DEPENDS = "virtual/fsboot virtual/bitstream"

inherit check_xsct_enabled deploy

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:microblaze = ".*"

MMI_FILE ?= "${RECIPE_SYSROOT}/boot/bitstream/system.mmi"
BIT_FILE ?= "${RECIPE_SYSROOT}/boot/bitstream/system.bit"
DATA_FILE ?= "${RECIPE_SYSROOT}/boot/fs-boot.elf"
B = "${WORKDIR}/build"

PROC ??= "kc705_i/microblaze_0"

SYSROOT_DIRS += "/boot/bitstream"

do_configure() {
    echo "MMI=${MMI_FILE} BIT=${BIT_FILE} DATA=${DATA_FILE} PROCESSOR=${PROC} OUT=${B}/download.bit" > ${B}/updatemem.conf
    if [ ! -e ${B}/updatemem.conf ]; then
        bbfatal "updatemem.conf creation failed. See log for details"
    fi
}

do_compile() {
    source ${B}/updatemem.conf
    echo "updatemem -meminfo ${MMI} -bit ${BIT} -data ${DATA} -proc ${PROCESSOR} -out ${OUT}"
    updatemem -meminfo ${MMI} -bit ${BIT} -data ${DATA} -proc ${PROCESSOR} -out ${OUT}
    if [ ! -e ${B}/download.bit ]; then
        bbfatal "download.bit failed. See log"
    fi
}

do_install() {
    if [ -e ${B}/download.bit ]; then
        install -Dm 0644 ${B}/download.bit ${D}/boot/bitstream/download.bit
    fi
}

inherit image-artifact-names

DOWNLOADBIT_BASE_NAME ?= "download-${MACHINE}${IMAGE_VERSION_SUFFIX}"

do_deploy() {
	if [ -e ${B}/download.bit ]; then
		install -Dm 0644 ${B}/download.bit ${DEPLOYDIR}/${DOWNLOADBIT_BASE_NAME}.bit
		ln -sf ${DOWNLOADBIT_BASE_NAME}.bit ${DEPLOYDIR}/download-${MACHINE}.bit
	fi
}

addtask do_deploy before do_build after do_compile

FILES:${PN} = "/boot/bitstream/download.bit"
