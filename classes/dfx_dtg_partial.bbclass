inherit dfx_common

DEPENDS:append = "${@'${STATIC_PN}' if d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1' else ''}"

XSCTH_MISC:append = " -rphdf ${WORKDIR}/${RP_XSCTH_HDF}"
XSCTH_HDF_PATH ?= "${STATIC_PN}.xsa"
XSCTH_HDF = "${@'${RECIPE_SYSROOT}/xsa/${XSCTH_HDF_PATH}' if d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1' else '${HDF_PATH}'}"

STATIC_PN ?= ""
RP_NAME ?= ""
RP_BASE_PATH ?= "${@'${STATIC_PN}/${RP_NAME}' if d.getVar('RP_NAME') else '${STATIC_PN}'}"
RP_PATH = "${@'csoc' if d.getVar('YAML_ENABLE_CLASSIC_SOC') == '1' else '${RP_BASE_PATH}'}"

python (){
    if not d.getVar("STATIC_PN") and d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1':
        raise bb.parse.SkipRecipe("STATIC_PN needs to be set to the package name that corresponds to the static xsa")

    d.setVar("RP_XSCTH_HDF",[a for a in d.getVar('SRC_URI').split() if '.xsa' in a][0].lstrip('file://'))

    # Optional inputs
    if '.dtsi' in d.getVar("SRC_URI"):
        d.setVar("PL_PARTIAL_CUSTOM_INCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.dtsi' in a][0].lstrip('file://')))
    if 'accel.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if 'accel.json' in a][0].lstrip('file://')))
}

do_configure:append () {
    # fpgamanager_dtg_dfx bbclass doesn't support multiple PR in signal xsa.
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
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/

    if [ -f ${B}/pl-partial-final*.dtbo ] && [ -n "${YAML_PARTIAL_OVERLAY_CUSTOM_DTS}" ]; then
        install -Dm 0644 ${B}/pl-partial-final*.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.dtbo
    elif [ -f ${B}/pl-partial*.dtbo ] && [ -z "${YAML_PARTIAL_OVERLAY_CUSTOM_DTS}" ]; then
        install -Dm 0644 ${B}/pl-partial*.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.dtbo
    else
        bbfatal "A partial dtbo ending with ${B}/pl-partial-final-<partial_design>_inst_<n>.dtbo expected but not found"
    fi

    if [ "${SOC_FAMILY}" != "versal" ]; then
        if [ -f ${B}/${PN}/hw/*_partial.bit ]; then
            install -Dm 0644 ${B}/${PN}/hw/*_partial.bit ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.bit
        else
            bbfatal "A partial bitstream ending with _partial.bit expected but not found"
        fi
    else
        if [ -f ${B}/${PN}/hw/*_partial.pdi ]; then
            install -Dm 0644 ${B}/${PN}/hw/*_partial.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.pdi
        else
            bbfatal "A partial pdi ending with _partial.pdi expected but not found"
        fi
    fi

    if [ -f ${WORKDIR}/${XCL_PATH}/*.xclbin ]; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.xclbin
    fi

    if [ -f ${WORKDIR}/${JSON_PATH}/accel.json ]; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/accel.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/accel.json
    fi
}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}"
