SUMMARY = "Generates new bitstream using updatemem tool with elf binary embedded"
DESCRIPTION = "This recipe will take the golden bitstream and using the \
updatemem tool, it will add an initial boot code (Ex: baremetal or \
FS-Boot ELF file) to it. By default, fs-boot.elf is embedded into the \
bitstream. This can be overridden by setting DATA_FILE in your build \
environment."

LICENSE = "BSD-3-Clause"

DEPENDS = "virtual/fsboot virtual/bitstream xsct-native"

inherit check_xsct_enabled xsct-tc deploy

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:microblaze = ".*"

MMI_FILE ?= "${RECIPE_SYSROOT}/boot/bitstream/system-${MACHINE}.mmi"
BIT_FILE ?= "${RECIPE_SYSROOT}/boot/bitstream/system-${MACHINE}.bit"
DATA_FILE ?= "${RECIPE_SYSROOT}/boot/fs-boot-${XILINX_XSCT_VERSION}+git.elf"
B = "${WORKDIR}/build"

PROC ??= "mb_preset_i/microblaze_0"

SYSROOT_DIRS += "/boot/bitstream"

PV .= "+${XILINX_XSCT_VERSION}"

# Function to get the processor instance path from the MMI file and set the
# PROC variable.
python get_instance_path() {
    import re

    mmi_file = d.getVar('MMI_FILE')

    try:
        with open(mmi_file, 'r') as f:
            content = f.read()

        pattern = r'InstPath\s*=\s*["\']([^"\']+)["\']'
        match = re.search(pattern, content, re.IGNORECASE)

        if match:
            instpath = match.group(1)
            bb.note("Auto-detected InstPath from MMI: %s" % instpath)
            d.setVar('PROC', instpath)

    except Exception as e:
        bb.warn("Could not read InstPath from MMI file: %s" % str(e))
}

do_configure[prefuncs] += "get_instance_path"

do_configure() {
    echo "MMI=${MMI_FILE} BIT=${BIT_FILE} DATA=${DATA_FILE} PROCESSOR=${PROC} OUT=${B}/download.bit" > ${B}/updatemem.conf
    if [ ! -e ${B}/updatemem.conf ]; then
        bbfatal "updatemem.conf creation failed. See log for details"
    fi
}

do_compile() {
    source ${B}/updatemem.conf
    echo "${TOOL_PATH}/updatemem -meminfo ${MMI} -bit ${BIT} -data ${DATA} -proc ${PROCESSOR} -out ${OUT}"
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
