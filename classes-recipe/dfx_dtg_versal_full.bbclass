#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#
# This bbclass is inherited by Versal Segmented Configuration firmware app
# recipes.

inherit dfx_dtg_common

# Recipes that inherit from this class need to use an appropriate machine
# override for COMPATIBLE_MACHINE to build successfully, don't allow building
# for Zynq-7000 and ZynqMP MACHINE.
COMPATIBLE_MACHINE:zynq = "^$"
COMPATIBLE_MACHINE:zynqmp = "^$"

python() {
    d.setVar("XSCTH_HDF_PATH",[a for a in d.getVar('SRC_URI').split() if '.xsa' in a][0].lstrip('file://'))

    # Optional inputs
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.xclbin' in a][0].lstrip('file://')))
    if '.dtsi' in d.getVar("SRC_URI"):
        d.setVar("CUSTOMPLINCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.dtsi' in a][0].lstrip('file://')))
    if 'shell.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if 'shell.json' in a][0].lstrip('file://')))
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/
    if [ -f ${B}/pl-final.dtbo ]; then
        install -Dm 0644 pl-final.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo
    else
        bbwarn "A xsa doesn't contain PL IP, hence ${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.dtbo is not needed"
    fi

    if [ "${SOC_FAMILY}" = "versal" ] || [ "${SOC_FAMILY}" = "versal-net" ]; then
        if [ -f ${B}/${PN}/hw/*_pld.pdi ]; then
            install -Dm 0644 ${B}/${PN}/hw/*_pld.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.pdi
        else
            bbfatal "A PL pdi ending with _pld.pdi in Segmented configuration xsa is expected but not found"
        fi
    fi

    if [ -f ${WORKDIR}/${XCL_PATH}/*.xclbin ]; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.xclbin
    fi

    if [ -f ${WORKDIR}/${JSON_PATH}/shell.json ]; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/shell.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${PN}/shell.json
    fi
}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${PN} "
