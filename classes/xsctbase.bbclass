inherit xsct-tc

B = "${WORKDIR}/build"

XSCTH_PROC_zynqmp ??= "psu_cortexa53_0"
XSCTH_PROC_zynq   ??= "ps7_cortexa9_0"
XSCTH_PROC_microblaze ??= "microblaze_0"
XSCTH_PROC_versal ??= "psv_cortexa72_0"

HDF_EXT ??= "xsa"
XSCTH_HDF ??= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.${HDF_EXT}"
XSCTH_APP ??= ""
XSCTH_REPO ??= "${S}"
XSCTH_PROJ ??= "${PN}"
XSCTH_WS ??= "${B}"
XSCTH_MISC ??= ""
XSCTH_SCRIPT ??= ""
XSCTH_EXECUTABLE ??= "executable.elf"
XSCTH_ARCH ?= "${@bb.utils.contains_any('XSCTH_PROC', ['psu_cortexa53_0', 'psv_cortexa72_0'], '64', '32', d)}"

PROJ_ARG ??= "-ws ${XSCTH_WS} -pname ${XSCTH_PROJ} -rp ${XSCTH_REPO}"
HW_ARG ??= "-processor ${XSCTH_PROC} -hdf ${XSCTH_HDF} -arch ${XSCTH_ARCH}"

do_configure[vardeps] += "XILINX_VER_MAIN"
do_configure[depends] += "virtual/hdf:do_deploy"
do_configure[lockfiles] = "${TMPDIR}/xsct-invoke.lock"
do_configure() {

    if [ -d "${S}/patches" ]; then
       rm -rf ${S}/patches
    fi

    if [ -d "${S}/.pc" ]; then
       rm -rf ${S}/.pc
    fi

    if [ -n "${XSCTH_MISC}" ]; then
        export MISC_ARG="${XSCTH_MISC}"
    fi

    if [ -n "${XSCTH_APP}" ]; then
        export APP_ARG=' -app "${XSCTH_APP}"'
    fi

    echo "MISC_ARG is ${MISC_ARG}"
    echo "APP_ARG is ${APP_ARG}"

    echo "Using xsct from: $(which xsct)"
    echo "cmd is: xsct -sdx -nodisp ${XSCTH_SCRIPT} ${PROJ_ARG} ${HW_ARG} ${APP_ARG} ${MISC_ARG}"

    eval xsct -sdx -nodisp ${XSCTH_SCRIPT} ${PROJ_ARG} ${HW_ARG} ${APP_ARG} ${MISC_ARG}

}

