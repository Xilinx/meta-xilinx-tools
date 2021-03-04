inherit xsct-tc

B ?= "${WORKDIR}/build"

XSCTH_PROC_DEFAULT_zynqmp     ??= "psu_cortexa53"
XSCTH_PROC_DEFAULT_zynq       ??= "ps7_cortexa9"
XSCTH_PROC_DEFAULT_microblaze ??= "microblaze"
XSCTH_PROC_DEFAULT_versal     ??= "psv_cortexa72"

XSCTH_PROC_IP ??= "${XSCTH_PROC_DEFAULT}"

HDF_EXT ??= "xsa"
XSCTH_HDF ??= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.${HDF_EXT}"
XSCTH_APP ??= ""
XSCTH_REPO ??= "${S}"
XSCTH_PROJ ??= "${PN}"
XSCTH_WS ??= "${B}"
XSCTH_MISC ??= ""
XSCTH_SCRIPT ??= ""
XSCTH_PROC ??= ""
XSCTH_EXECUTABLE ??= "executable.elf"
XSCTH_ARCH ?= "${@bb.utils.contains_any('XSCTH_PROC_IP', ['psu_cortexa53', 'psv_cortexa72'], '64', '32', d)}"

PROJ_ARG ??= "-ws ${XSCTH_WS} -pname ${XSCTH_PROJ} -rp ${XSCTH_REPO}"
HW_ARG ??= "-processor_ip ${XSCTH_PROC_IP} -hdf ${XSCTH_HDF} -arch ${XSCTH_ARCH} ${@['', '-processor ${XSCTH_PROC}'][d.getVar('XSCTH_PROC', True) != '']}"

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

