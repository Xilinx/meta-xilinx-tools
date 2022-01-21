LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit devicetree xsctyaml xsctbase

require recipes-bsp/device-tree/device-tree.inc

XSCTH_PROC:versal ?= "psv_cortexa72_0"

#overwrite HW_ARG defiend in xsctbase
HW_ARG ?= "-processor_ip ${XSCTH_PROC_IP} -rphdf ${WORKDIR}/${RP_XSCTH_HDF}  -hdf ${RECIPE_SYSROOT}/xsa/${XSCTH_HDF_PATH} -arch ${XSCTH_ARCH} ${@['', '-processor ${XSCTH_PROC}'][d.getVar('XSCTH_PROC', True) != '']}"

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI:append = " \
    file://dtgen_dfx.tcl \
    file://app_dfx.tcl \
    "
XSCTH_SCRIPT = "${WORKDIR}/app_dfx.tcl"

XSCTH_PROJ = "${PN}/psv_cortexa72_0/device_tree_domain/bsp/"

PROVIDES = ''

DEPENDS = "dtc-native bootgen-native ${STATIC_PN}"

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:versal = ".*"

DT_PADDING_SIZE = "0x1000"

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_PROJ}"

XSCTH_BUILD_CONFIG = 'Release'
XSCTH_MISC = " -hdf_type ${HDF_EXT} -hwpname ${PN}"
XSCTH_HDF = "${WORKDIR}/${XSCTH_HDF_PATH}"
XSCTH_HDF_PATH ?= "${STATIC_PN}.xsa"

YAML_FIRMWARE_NAME:versal = "${PN}.pdi"

STATIC_PN ?= ""
RP_NAME ?= ""

do_fetch[cleandirs] = "${B}"
do_configure[cleandirs] = "${B}"

python (){
    if not d.getVar("STATIC_PN"):
        raise bb.parse.SkipRecipe("STATIC_PN needs to be set to the package name that corresponds to the static xsa")

    if d.getVar("SRC_URI").count(".xsa") != 1:
        raise bb.parse.SkipRecipe("Need one '.xsa' file added to SRC_URI")

    d.setVar("RP_XSCTH_HDF",[a for a in d.getVar('SRC_URI').split('file://') if '.xsa' in a][0])

    #optional inputs
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.xclbin' in a][0]))
    if '.dtsi' in d.getVar("SRC_URI"):
        d.setVar("CUSTOMPLINCLUDE_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if '.dtsi' in a][0]))
    if 'accel.json' in d.getVar("SRC_URI"):
        d.setVar("JSON_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split('file://') if 'accel.json' in a][0]))
}


do_configure:prepend() {

    if [ "${FPGA_MNGR_RECONFIG_ENABLE}" != "1" ] ; then
        bbfatal "Using fpga-manager.bbclass requires fpga-overlay DISTRO_FEATURE or FPGA_MNGR_RECONFIG_ENABLE to be set"
    fi
}

do_configure:append () {
    if ls ${WORKDIR}/${CUSTOMPLINCLUDE_PATH}/*.dtsi >/dev/null 2>&1; then
        cp ${WORKDIR}/${CUSTOMPLINCLUDE_PATH}/*.dtsi ${XSCTH_WS}/${XSCTH_PROJ}/pl-custom.dtsi
    fi
}
do_compile:prepend() {
    listpath = d.getVar("DT_FILES_PATH")
    try:
        os.remove(os.path.join(listpath, "system.dts"))
    except OSError:
        pass
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${STATIC_PN}/${RP_NAME}/${PN}/
    install -Dm 0644 pl.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${STATIC_PN}/${RP_NAME}/${PN}/${PN}.dtbo
    if ls ${B}/${PN}/hw/*_partial.pdi >/dev/null 2>&1; then
        install -Dm 0644 ${B}/${PN}/hw/*_partial.pdi ${D}${nonarch_base_libdir}/firmware/xilinx/${STATIC_PN}/${RP_NAME}/${PN}/${PN}.pdi
    else
        bbfatal "A partial pdi ending with _partial.pdi expected but not found"
    fi
    if ls ${WORKDIR}/${XCL_PATH}/*.xclbin >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${XCL_PATH}/*.xclbin ${D}${nonarch_base_libdir}/firmware/xilinx/${STATIC_PN}/${RP_NAME}/${PN}/${PN}.xclbin
    fi
    if ls ${WORKDIR}/${JSON_PATH}/accel.json >/dev/null 2>&1; then
        install -Dm 0644 ${WORKDIR}/${JSON_PATH}/accel.json ${D}/${nonarch_base_libdir}/firmware/xilinx/${STATIC_PN}/${RP_NAME}/${PN}/accel.json
    fi
}

do_deploy[noexec] = "1"

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${STATIC_PN}/${RP_NAME}/${PN}"
