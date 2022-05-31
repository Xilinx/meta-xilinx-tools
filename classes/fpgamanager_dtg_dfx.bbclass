LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit fpgamanager_common

DEPENDS:append = "${@'${STATIC_PN}' if d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1' else ''}"

XSCTH_MISC:append = " -rphdf ${WORKDIR}/${RP_XSCTH_HDF}"
XSCTH_HDF_PATH ?= "${STATIC_PN}.xsa"
XSCTH_HDF = "${@'${RECIPE_SYSROOT}/xsa/${XSCTH_HDF_PATH}' if d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1' else '${HDF_PATH}'}"

STATIC_PN ?= ""
RP_NAME ?= ""
RP_PATH = "${@'${STATIC_PN}/${RP_NAME}' if d.getVar('RP_NAME') and d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1' else 'csoc'}"

python (){
    if not d.getVar("STATIC_PN") and d.getVar('YAML_ENABLE_CLASSIC_SOC') != '1':
        raise bb.parse.SkipRecipe("STATIC_PN needs to be set to the package name that corresponds to the static xsa")

    d.setVar("RP_XSCTH_HDF",[a for a in d.getVar('SRC_URI').split() if '.xsa' in a][0].lstrip('file://'))

    #optional inputs
    if '.dtsi' in d.getVar("SRC_URI"):
        d.setVar("CUSTOMPLINCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.dtsi' in a][0].lstrip('file://')))
    if 'accel.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if 'accel.json' in a][0].lstrip('file://')))
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/
    if ls ${B}/*inst_*.dtbo >/dev/null 2>&1; then
        install -Dm 0644 *inst_*.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.dtbo
    else
        bbfatal "A partial dtbo ending with ${B}/<partial_design>_inst_<n>.dtbo expected but not found"
    fi

    if [ "${SOC_FAMILY}" != "versal" ]; then
        if ls ${B}/${PN}/hw/*_partial.bit > /dev/null 2>&1; then
            install -Dm 0644 ${B}/${PN}/hw/*_partial.bit ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.bit
        else
            bbwarn "A partial bitstream ending with _partial.bit expected but not found"
        fi
    else
        if ls ${B}/${PN}/hw/*_partial.pdi > /dev/null 2>&1; then
            install -Dm 0644 ${B}/${PN}/hw/*_partial.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.pdi
        else
            bbfatal "A partial pdi ending with _partial.pdi expected but not found"
        fi
    fi

    if ls ${WORKDIR}/${XCL_PATH}/*.xclbin >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/${PN}.xclbin
    fi
    if ls ${WORKDIR}/${JSON_PATH}/accel.json >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/accel.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}/accel.json
    fi
}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${RP_PATH}/${PN}"
