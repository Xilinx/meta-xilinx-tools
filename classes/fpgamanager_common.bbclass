inherit devicetree xsctyaml xsctbase
PROVIDES = ''

require recipes-bsp/device-tree/device-tree.inc

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI:append = " \
    file://dtgen_dfx.tcl \
    "
# TCL scripts used for Static and Partial xsa parsing.
XSCTH_SCRIPT = "${WORKDIR}/dtgen_dfx.tcl"

# XSCT output directory when workspace is set(-ws option) as follows:
# Versal = hw_project_name/psv_cortexa72_0/device_tree_domain/bsp/
# ZynqMP = hw_project_name/psv_cortexa53_0/device_tree_domain/bsp/
XSCTH_DT_PATH = "${XSCTH_PROJ}/${XSCTH_PROC_IP}_0/device_tree_domain/bsp/"

# XSCT extracted bitstream directory is hw_project_name/hw/*.bit
XSCTH_HW_PATH = "${XSCTH_WS}/${XSCTH_PROJ}/hw"

S = "${WORKDIR}/git"

DEPENDS = "\
    dtc-native \
    bootgen-native \
    virtual/dtb \
    "

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:zynqmp = ".*"
COMPATIBLE_MACHINE:versal = ".*"

BOOTGEN_FLAGS ?= " -arch ${SOC_FAMILY} ${@bb.utils.contains('SOC_FAMILY','zynqmp','-w','-process_bitstream bin',d)}"

DT_FILES_PATH = "${XSCTH_WS}/${XSCTH_DT_PATH}"

XSCTH_BUILD_CONFIG = 'Release'
XSCTH_MISC = " -hdf_type ${HDF_EXT} -hwpname ${PN}"
XSCTH_HDF = "${WORKDIR}/${XSCTH_HDF_PATH}"

YAML_FIRMWARE_NAME = "${PN}.bit"
YAML_FIRMWARE_NAME:versal = "${PN}.pdi"

do_fetch[cleandirs] = "${B}"
do_configure[cleandirs] = "${B}"

python (){

    if d.getVar("SRC_URI").count(".xsa") != 1:
        raise bb.parse.SkipRecipe("Need one '.xsa' file added to SRC_URI")


    #optional inputs
    if '.xclbin' in d.getVar("SRC_URI"):
        d.setVar("XCL_PATH",os.path.dirname([a for a in d.getVar('SRC_URI').split() if '.xclbin' in a][0].lstrip('file://')))
}
do_configure:prepend() {

    if ${@bb.utils.contains('MACHINE_FEATURES', 'fpga-overlay', 'false', 'true', d)}; then
        bbwarn "Using fpgamanager_base.bbclass requires fpga-overlay MACHINE_FEATURE to be enabled"
    fi
}

do_configure:append () {
    if [ -f ${WORKDIR}/${CUSTOMPLINCLUDE_PATH}/*.dtsi ]; then
        cp ${WORKDIR}/${CUSTOMPLINCLUDE_PATH}/*.dtsi ${XSCTH_WS}/${XSCTH_DT_PATH}/pl-custom.dtsi
    fi
}
do_compile:prepend() {
    listpath = d.getVar("DT_FILES_PATH")
    try:
        os.remove(os.path.join(listpath, "system.dts"))
    except OSError:
        pass
}

do_deploy[noexec] = "1"
