# Note: This bbclass is a temporary for 2023.2 release and DO NOT inherit this
# bbclass directly. For more details refer README.dfx.dtg.<arch>.<design>.md file.

inherit dfx_common

python() {
    d.setVar("XSCTH_HDF_PATH",[a for a in d.getVar('SRC_URI').split() if '.xsa' in a][0].lstrip('file://'))

    # Optional inputs
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.xclbin' in a][0].lstrip('file://')))
    if '.dtsi' in d.getVar("SRC_URI") and d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1':
        d.setVar("CUSTOMPLINCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.dtsi' in a][0].lstrip('file://')))
    if 'shell.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if 'shell.json' in a][0].lstrip('file://')))
}

python devicetree_do_compile:append() {
    import glob, subprocess, shutil
    if glob.glob(d.getVar('XSCTH_HW_PATH') + '/*.bit'):
        pn = d.getVar('PN')
        biffile = pn + '.bif'

        with open(biffile, 'w') as f:
            f.write('all:\n{\n\t' + glob.glob(d.getVar('XSCTH_HW_PATH') + '/*.bit')[0] + '\n}')

        bootgenargs = ["bootgen"] + (d.getVar("BOOTGEN_FLAGS") or "").split()
        bootgenargs += ["-image", biffile, "-o", pn + ".bit.bin"]
        subprocess.run(bootgenargs, check = True)

        # In Zynq7k using "-process_bitstream bin" bootgen flag, bit.bin file is
        # generated in XSCTH_HW_PATH directory with <xsa_name>.bit.bin file,
        # Hence we need to move this file from XSCTH_HW_PATH to XSCTH_WS
        # directory and rename to ${PN}.bit.bin for do_install task.
        arch = d.getVar('SOC_FAMILY')
        if arch == 'zynq':
            src_bitbin_file = glob.glob(d.getVar('XSCTH_HW_PATH') + '/*.bit.bin')[0]
            dst_bitbin_file = d.getVar('XSCTH_WS') + '/' + pn + '.bit.bin'
            shutil.move(src_bitbin_file, dst_bitbin_file)

        if not os.path.isfile(pn + ".bit.bin"):
            bb.fatal("bootgen failed. Enable -log debug with bootgen and check logs")
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/
    if [ -f ${B}/pl-final.dtbo ]; then
        install -Dm 0644 pl-final.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo
    else
        bbwarn "A static xsa doesn't contain PL IP, hence ${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo is not needed"
    fi

    if [ "${SOC_FAMILY}" != "versal" ]; then
        if [ -f ${B}/${PN}.bit.bin ]; then
            install -Dm 0644 ${B}/${PN}.bit.bin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.bit.bin
        else
            bbwarn "A Full or Static(DFx) bitstream expected but not found"
        fi
    else
        if [ -f ${B}/${PN}/hw/*.pdi ]; then
            install -Dm 0644 ${B}/${PN}/hw/*.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.pdi
        else
            bbwarn "A static pdi expected but not found"
        fi
    fi

    if [ -f ${WORKDIR}/${XCL_PATH}/*.xclbin ]; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.xclbin
    fi

    if [ -f ${WORKDIR}/${JSON_PATH}/shell.json ]; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/shell.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${PN}/shell.json
    fi

    # In case of DFx designs, To create a new reconfigurable partition(RP)
    # platform (using "platform create [options]" command) from RP firmware
    # recipe depends on DFx Static recipe xsa(${STATIC_PN}). Hence this DFx Static
    # xsa will be packaged to recipe-sysroots but not installed on target rootfs.
    install -d ${D}/xsa
    install -Dm 0644 ${WORKDIR}/${XSCTH_HDF_PATH} ${D}/xsa/${PN}.xsa

}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${PN} "

# For DFx use case only.
FILES:${PN}-xsa += "xsa/*"
PACKAGES += "${PN}-xsa"
SYSROOT_DIRS += "/xsa"
