SUMMARY = "Generates boot.bin using bootgen tool"
DESCRIPTION = "Manages task dependencies and creation of boot.bin. Use the \
BIF_PARTITION_xyz global variables and flags to determine what makes it into \
the image."

LICENSE = "BSD"

include machine-xilinx-${SOC_FAMILY}.inc

inherit deploy

PROVIDES = "virtual/boot-bin"

do_configure[depends] += "${@get_bootbin_depends(d)}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

BIF_FILE_PATH ?= "${B}/bootgen.bif"

BOOTGEN_EXTRA_ARGS ?= ""

BIF_PARTITION_ATTR_zynqmp = "${@bb.utils.contains('IMAGE_FEATURES', 'fpga-manager', 'fsbl pmu atf u-boot', 'fsbl bitstream pmu atf u-boot', d)}"

do_fetch[noexec] = "1"
do_unpack[noexec] = "1"
do_patch[noexec] = "1"

def get_bootbin_depends(d):
    bootbindeps = ""
    bifpartition = (d.getVar("BIF_PARTITION_ATTR", True) or "").split()
    attrdepends = d.getVarFlags("BIF_PARTITION_DEPENDS") or {}
    for cfg in bifpartition:
        if cfg in attrdepends:
            bootbindeps = bootbindeps + " " + attrdepends[cfg]

    return bootbindeps

def create_bif(config, attrflags, attrimage, common_attr, biffd, d):
    import re, os
    for cfg in config:
        if cfg not in attrflags and common_attr:
            error_msg = "%s: invalid ATTRIBUTE" % (cfg)
            bb.error("BIF attribute Error: %s " % (error_msg))
        else:
            if common_attr:
                cfgval = attrflags[cfg].split(',')
                cfgstr = "\t [%s] %s\n" % (cfg,', '.join(cfgval))
            else:
                if cfg not in attrimage:
                    error_msg = "%s: invalid or missing elf or image" % (cfg)
                    bb.error("BIF atrribute Error: %s " % (error_msg))
                imagestr = d.expand(attrimage[cfg])
                if os.stat(imagestr).st_size == 0:
                    bb.warn("Empty file %s, excluding from bif file" %(imagestr))
                    continue
                if cfg in attrflags:
                    cfgval = attrflags[cfg].split(',')
                    cfgstr = "\t [%s] %s\n" % (', '.join(cfgval), imagestr)
                else:
                    cfgstr = "\t %s\n" % (imagestr)
            biffd.write(cfgstr)

    return

python do_configure() {

    fp = d.getVar("BIF_FILE_PATH", True)
    biffd = open(fp, 'w')
    biffd.write("the_ROM_image:\n")
    biffd.write("{\n")

    bifattr = (d.getVar("BIF_COMMON_ATTR", True) or "").split()
    if bifattr:
        attrflags = d.getVarFlags("BIF_COMMON_ATTR") or {}
        create_bif(bifattr, attrflags,'', 1, biffd, d)

    bifpartition = (d.getVar("BIF_PARTITION_ATTR", True) or "").split()
    if bifpartition:
        attrflags = d.getVarFlags("BIF_PARTITION_ATTR") or {}
        attrimage = d.getVarFlags("BIF_PARTITION_IMAGE") or {}
        create_bif(bifpartition, attrflags, attrimage, 0, biffd, d)

    biffd.write("}")
    biffd.close()
}

do_configure[vardeps] += "BIF_PARTITION_ATTR BIF_PARTITION_IMAGE BIF_COMMON_ATTR"

do_compile() {
    cd ${WORKDIR}
    rm -f ${B}/BOOT.bin
    bootgen -image ${BIF_FILE_PATH} -arch ${SOC_FAMILY} ${BOOTGEN_EXTRA_ARGS} -w -o ${B}/BOOT.bin
    if [ ! -e ${B}/BOOT.bin ]; then
        bbfatal "bootgen failed. See log"
    fi
}

do_install() {
	:
}

BOOTBIN_BASE_NAME ?= "BOOT-${MACHINE}-${DATETIME}"
BOOTBIN_BASE_NAME[vardepsexclude] = "DATETIME"

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${B}/BOOT.bin ${DEPLOYDIR}/${BOOTBIN_BASE_NAME}.bin
    ln -sf ${BOOTBIN_BASE_NAME}.bin ${DEPLOYDIR}/BOOT-${MACHINE}.bin
}
addtask do_deploy before do_build after do_compile

