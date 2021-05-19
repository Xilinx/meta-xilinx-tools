LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit devicetree xsctdt xsctyaml
PROVIDES = ''

require recipes-bsp/device-tree/device-tree.inc

DEPENDS = "dtc-native bootgen-native"

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE_zynqmp = ".*"
COMPATIBLE_MACHINE_zynq = ".*"

DT_PADDING_SIZE = "0x1000"

BOOTGEN_FLAGS ?= " -arch ${SOC_FAMILY} ${@bb.utils.contains('SOC_FAMILY','zynqmp','-w','-process_bitstream bin',d)}"

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"

XSCTH_BUILD_CONFIG = 'Release'
XSCTH_MISC = " -hdf_type ${HDF_EXT}"
XSCTH_HDF = "${WORKDIR}/${XSCTH_HDF_PATH}"

YAML_OVERLAY_CUSTOM_DTS = "pl-final.dts"
YAML_FIRMWARE_NAME = "${PN}.bit"

do_fetch[cleandirs] = "${B}"
do_configure[cleandirs] = "${B}"

python (){

    if d.getVar("SRC_URI").count(".xsa") != 1 or d.getVar("SRC_URI").count("shell.json") != 1:
        raise bb.parse.SkipRecipe("Need one '.xsa' and one 'shell.json' file added to SRC_URI")

    d.setVar("XSCTH_HDF_PATH",[a for a in d.getVar('SRC_URI').split('file://') if '.xsa' in a][0])
    d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if 'shell.json' in a][0]))

    #optional inputs
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.xclbin' in a][0]))
    if '.dtsi' in d.getVar("SRC_URI"):
        d.setVar("CUSTOMPLINCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.dtsi' in a][0]))
}


do_configure_prepend() {

    if ${@bb.utils.contains('MACHINE_FEATURES', 'fpga-overlay', 'false', 'true', d)}; then
        bbwarn "Using fpga-manager.bbclass requires fpga-overlay MACHINE_FEATURE to be enabled"
    fi
}

do_configure_append () {
    if ls ${WORKDIR}/${CUSTOMPLINCLUDE_PATH}/*.dtsi >/dev/null 2>&1; then
        cp ${WORKDIR}/${CUSTOMPLINCLUDE_PATH}/*.dtsi ${XSCTH_WS}/${XSCTH_PROJ}/pl-custom.dtsi
    fi
}
do_compile_prepend() {
    listpath = d.getVar("DT_FILES_PATH")
    try:
        os.remove(os.path.join(listpath, "system.dts"))
    except OSError:
        pass
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
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/
    install -Dm 0644 pl-final.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo
    install -Dm 0644 ${PN}.bit.bin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.bit.bin
    if ls ${WORKDIR}/${XCL_PATH}/*.xclbin >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.xclbin
    fi
    install -Dm 0644 ${WORKDIR}/${JSON_PATH}/shell.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${PN}/shell.json
}

do_deploy[noexec] = "1"

FILES_${PN} += "${nonarch_base_libdir}/firmware/xilinx/${PN}"
