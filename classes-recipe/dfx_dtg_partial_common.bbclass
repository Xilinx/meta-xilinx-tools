#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#
# This bbclass provides common code for ZynqMP and Versal DFx Partial firmware
# bbclass.

inherit dfx_dtg_common

# Recipes that inherit from this class need to use an appropriate machine
# override for COMPATIBLE_MACHINE to build successfully, don't allow building
# for Zynq-7000 as dfx designs are not supported for Zynq-7000.
COMPATIBLE_MACHINE:zynq = "^$"

DEPENDS:append = "${@'${STATIC_PN}'}"

XSCTH_MISC:append = " -rphdf ${WORKDIR}/${RP_XSCTH_HDF}"
XSCTH_HDF_PATH ?= "${STATIC_PN}.xsa"
XSCTH_HDF = "${@'${RECIPE_SYSROOT}/xsa/${XSCTH_HDF_PATH}'}"

STATIC_PN ?= ""
RP_NAME ?= ""
RP_BASE_PATH ?= "${@'${STATIC_PN}/${RP_NAME}' if d.getVar('RP_NAME') else '${STATIC_PN}'}"

python (){
    if not d.getVar("STATIC_PN"):
        raise bb.parse.SkipRecipe("STATIC_PN needs to be set to the package name that corresponds to the static xsa")

    d.setVar("RP_XSCTH_HDF",[a for a in d.getVar('SRC_URI').split() if '.xsa' in a][0].lstrip('file://'))

    # Optional inputs
    if '.dtsi' in d.getVar("SRC_URI"):
        d.setVar("PL_PARTIAL_CUSTOM_INCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.dtsi' in a][0].lstrip('file://')))
    if 'accel.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if 'accel.json' in a][0].lstrip('file://')))
}

# In case of DFx partial, it will have both static and partial bistream extracted
# in XSCTH_HW_PATH durin platform generate operation. Hence convert *_partial.bit
# to bin format.
python devicetree_do_compile:append() {
    import glob, subprocess, shutil
    if glob.glob(d.getVar('XSCTH_HW_PATH') + '/*_partial.bit'):
        pn = d.getVar('PN')
        biffile = pn + '.bif'

        with open(biffile, 'w') as f:
            f.write('all:\n{\n\t' + glob.glob(d.getVar('XSCTH_HW_PATH') + '/*_partial.bit')[0] + '\n}')

        bootgenargs = ["bootgen"] + (d.getVar("BOOTGEN_FLAGS") or "").split()
        bootgenargs += ["-image", biffile, "-o", pn + ".bin"]
        subprocess.run(bootgenargs, check = True)

        if not os.path.isfile(pn + ".bin"):
            bb.fatal("bootgen failed. Enable -log debug with bootgen and check logs")
}

do_configure:append () {
    # dfx_dtg_partial bbclass doesn't support multiple PR in signal xsa.
    # DTG will suffix RpRm name to pl-partial-custom dtsi file when xsa has
    # more than one PR DTG will generate pl-partial-custom-$RpRm.dtsi for each
    # PR. Since this bbclass supports only one PR per xsa, it will find and use
    # the first pl-partial-custom-$RpRm.dtsi file we find.
    if [ $(find "${XSCTH_WS}/${XSCTH_DT_PATH}" -iname 'pl-partial-custom-*.dtsi' | wc -l) -gt 1 ]; then
        bbfatal "XSA contains more than one pl-partial-custom dtsi in ${XSCTH_WS}/${XSCTH_DT_PATH} which is not supported from this bbclass"
    else
        for dtsi in `find "${XSCTH_WS}/${XSCTH_DT_PATH}" -iname 'pl-partial-custom*.dtsi'`; do
            bbnote "Found pl-partial-custom dtsi file: $dtsi"
            if [ -f "$dtsi" ]; then
                # By default YAML_PARTIAL_OVERLAY_CUSTOM_DTS is set from yocto
                # In some use case user can unset this variable from local.conf
                # In such case copy PL_PARTIAL_CUSTOM_INCLUDE_PATH dtsi file only if
                # YAML_PARTIAL_OVERLAY_CUSTOM_DTS is set else ignore it
                if [ -f ${WORKDIR}/${PL_PARTIAL_CUSTOM_INCLUDE_PATH}/*.dtsi ]; then
                    cp ${WORKDIR}/${PL_PARTIAL_CUSTOM_INCLUDE_PATH}/*.dtsi $dtsi
                fi
                break
            else
                bbfatal "No pl-partial-custom dtsi in ${XSCTH_WS}/${XSCTH_DT_PATH}"
            fi
        done
    fi
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/

    if [ -f ${B}/pl-partial-final*.dtbo ] && [ -n "${YAML_PARTIAL_OVERLAY_CUSTOM_DTS}" ]; then
        install -Dm 0644 ${B}/pl-partial-final*.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/${PN}.dtbo
    elif [ -f ${B}/pl-partial*.dtbo ] && [ -z "${YAML_PARTIAL_OVERLAY_CUSTOM_DTS}" ]; then
        install -Dm 0644 ${B}/pl-partial*.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/${PN}.dtbo
    else
        bbfatal "A partial dtbo ending with ${B}/pl-partial-final-<partial_design>_inst_<n>.dtbo expected but not found"
    fi

    # In ZynqMP DFx Partial, if bin is included instead of .bit in xsa then .bin
    # will be copied from directly from ${B}/${PN}/hw/ to destination directory
    # else copy converted bit to bin file from ${B}/${PN}.bin to destination
    # directory.
    if [ "${SOC_FAMILY}" = "zynqmp" ]; then
        if [ -f ${B}/${PN}/hw/*_partial.bin ]; then
            install -Dm 0644 ${B}/${PN}/hw/*_partial.bin ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/${PN}.bit
        elif [ -f ${B}/${PN}.bin ]; then
            install -Dm 0644 ${B}/${PN}.bin ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/${PN}.bin
        else
            bbfatal "A partial bitstream ending with .bin expected but not found"
        fi
    else
        if [ -f ${B}/${PN}/hw/*_partial.pdi ]; then
            install -Dm 0644 ${B}/${PN}/hw/*_partial.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/${PN}.pdi
        else
            bbfatal "A partial pdi ending with _partial.pdi expected but not found"
        fi
    fi

    if [ -f ${WORKDIR}/${XCL_PATH}/*.xclbin ]; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/${PN}.xclbin
    fi

    if [ -f ${WORKDIR}/${JSON_PATH}/accel.json ]; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/accel.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}/accel.json
    fi
}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${RP_BASE_PATH}/${PN}"
