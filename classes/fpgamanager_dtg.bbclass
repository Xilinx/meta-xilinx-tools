LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit fpgamanager_common
COMPATIBLE_MACHINE:zynq = ".*"
YAML_OVERLAY_CUSTOM_DTS = "pl-final.dts"

python (){
    d.setVar("XSCTH_HDF_PATH",[a for a in d.getVar('SRC_URI').split() if '.xsa' in a][0].lstrip('file://'))

    #optional inputs
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.xclbin' in a][0].lstrip('file://')))
    if '.dtsi' in d.getVar("SRC_URI") and d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1':
        d.setVar("CUSTOMPLINCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.dtsi' in a][0].lstrip('file://')))
    if 'shell.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if 'shell.json' in a][0].lstrip('file://')))
}

python devicetree_do_compile:append() {
    import glob, subprocess
    if glob.glob(d.getVar('DT_FILES_PATH') + '/*.bit'):
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
    if ls ${B}/pl-final.dtbo >/dev/null 2>&1; then
        install -Dm 0644 pl-final.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo
    else
        bbwarn "A static xsa doesn't contain PL IP, hence ${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo is not needed"
    fi

    if [ "${SOC_FAMILY}" != "versal" ]; then
        if ls *.bit.bin >/dev/null 2>&1; then
             install -Dm 0644 ${PN}.bit.bin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.bit.bin
        else
            bbwarn "A static or full bitstream expected but not found"
        fi
    else
        if ls ${B}/${PN}/hw/*.pdi > /dev/null 2>&1; then
            install -Dm 0644 ${B}/${PN}/hw/*.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.pdi
        else
            bbwarn "A static pdi expected but not found"
        fi
    fi

    if ls ${WORKDIR}/${XCL_PATH}/*.xclbin >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.xclbin
    fi
    if ls ${WORKDIR}/${JSON_PATH}/shell.json >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/shell.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${PN}/shell.json
    fi

    #installing xsa here purely to use in dfxsa recipe from recipe-sysroots. (will be putting in different package so its not installed on target)
    install -d ${D}/xsa
    install -Dm 0644 ${WORKDIR}/${XSCTH_HDF_PATH} ${D}/xsa/${PN}.xsa

}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${PN} "

FILES:${PN}-xsa += "xsa/*"
PACKAGES += "${PN}-xsa"
SYSROOT_DIRS += "/xsa"
