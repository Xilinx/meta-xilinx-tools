LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit update-alternatives devicetree

DEPENDS = "virtual/dtb dtc-native"
RDEPENDS_${PN} = "fpga-init"

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE_zynqmp = ".*"
COMPATIBLE_MACHINE_zynq = ".*"

PROVIDES = ""

DT_PADDING_SIZE = "0x1000"

BOOTGEN_FLAGS ?= " -arch ${SOC_FAMILY} ${@bb.utils.contains('SOC_FAMILY','zynqmp','-w','-process_bitstream bin',d)}"

python do_configure() {
    if not d.getVar('FPGA_MNGR_RECONFIG_ENABLE') == '1':
        bb.fatal("Using fpga-manager.bbclass requires fpga-manager IMAGE_FEATURE or FPGA_MNGR_RECONFIG_ENABLE to be set")
}

python devicetree_do_compile_append() {
    import glob, subprocess
    pn = d.getVar('PN')
    biffile = pn + '.bif'

    with open(biffile, 'w') as f:
        f.write('all:\n{\n\t' + glob.glob(d.getVar('DT_FILES_PATH') + '/*.bit')[0] + '\n}')

    bootgenargs = ["bootgen"] + (d.getVar("BOOTGEN_FLAGS") or "").split()
    bootgenargs += ["-image", biffile, "-o", pn + ".bit.bin"]
    subprocess.run(bootgenargs, check = True)

    if not os.path.isfile(pn + ".bit.bin"):
        bb.fatal("bootgen failed. Enable -log debug with bootgen and check logs")

    with open(pn + ".env", 'w') as f:
        f.write("DTBO=/lib/firmware/%s/%s.dtbo\n" % (pn, pn) )
        f.write("BIN=/lib/firmware/%s/%s.bit.bin\n" % (pn, pn) )
}

do_install() {
    install -d ${D}/lib/firmware/${PN}/
    install -Dm 0644 *.dtbo ${D}/lib/firmware/${PN}/${PN}.dtbo
    install -Dm 0644 ${PN}.bit.bin ${D}/lib/firmware/${PN}/${PN}.bit.bin

    install -Dm 0644 ${PN}.env ${D}/lib/firmware/${PN}/${PN}.env
}

do_deploy[noexec] = "1"

FILES_${PN} += "/lib/firmware/${PN}"

ALTERNATIVE_${PN} = "overlay"
ALTERNATIVE_TARGET[overlay] = "/lib/firmware/${PN}/${PN}.env"
ALTERNATIVE_LINK_NAME[overlay] = "/lib/firmware/fpga-default.env"
