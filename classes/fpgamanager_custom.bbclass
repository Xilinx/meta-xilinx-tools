LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit devicetree

DEPENDS = "dtc-native bootgen-native"

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE_zynqmp = ".*"
COMPATIBLE_MACHINE_zynq = ".*"

PROVIDES = ""

do_fetch[cleandirs] = "${B}"

DT_PADDING_SIZE = "0x1000"
BOOTGEN_FLAGS ?= " -arch ${SOC_FAMILY} ${@bb.utils.contains('SOC_FAMILY','zynqmp','-w','-process_bitstream bin',d)}"

DT_FILES_PATH = "${WORKDIR}/${DTSI_PATH}"

python (){

    if d.getVar("SRC_URI").count(".dtsi") != 1 or d.getVar("SRC_URI").count(".bit") != 1:
        bb.fatal("Need one '.dtsi' and one '.bit' file added to SRC_URI")

    d.setVar("DTSI_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.dtsi' in a][0]))
    d.setVar("BIT_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.bit' in a][0]))

    #optional input
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.xclbin' in a][0]))
}
python do_configure() {
    import glob, re, shutil

    if not d.getVar('FPGA_MNGR_RECONFIG_ENABLE') == '1':
        bb.fatal("Using fpga-manager.bbclass requires fpga-manager IMAGE_FEATURE or FPGA_MNGR_RECONFIG_ENABLE to be set")

    #renaming firmware-name using $PN as bitstream will be renamed using $PN when generating the bin file
    orig_dtsi = glob.glob(d.getVar('WORKDIR')+d.getVar('DTSI_PATH') + '/*.dtsi')[0]
    new_dtsi = d.getVar('WORKDIR') + '/pl.dtsi_firmwarename'
    with open(new_dtsi, 'w') as newdtsi:
        with open(orig_dtsi) as olddtsi:
            for line in olddtsi:
                newdtsi.write(re.sub('firmware-name.*\".*\"','firmware-name = \"'+d.getVar('PN')+'.bit.bin\"',line))
    shutil.move(new_dtsi,orig_dtsi)
}

python devicetree_do_compile_append() {
    import glob, subprocess
    pn = d.getVar('PN')
    biffile = pn + '.bif'

    with open(biffile, 'w') as f:
        f.write('all:\n{\n\t' + glob.glob(d.getVar('WORKDIR')+d.getVar('BIT_PATH') + '/*.bit')[0] + '\n}')

    bootgenargs = ["bootgen"] + (d.getVar("BOOTGEN_FLAGS") or "").split()
    bootgenargs += ["-image", biffile, "-o", pn + ".bit.bin"]
    subprocess.run(bootgenargs, check = True)

    if not os.path.isfile(pn + ".bit.bin"):
        bb.fatal("bootgen failed. Enable -log debug with bootgen and check logs")
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/
    install -Dm 0644 *.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo
    install -Dm 0644 ${PN}.bit.bin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.bit.bin
    if ls ${WORKDIR}/${XCL_PATH}/*.xclbin >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.xclbin
    fi
}

do_deploy[noexec] = "1"

FILES_${PN} += "${nonarch_base_libdir}/firmware/xilinx/{PN}"
