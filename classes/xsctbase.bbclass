DEPENDS += "virtual/hdf"

XSCTH_PROC_zynqmp ??= "psu_cortexa53_0"
XSCTH_PROC_zynq   ??= "ps7_cortexa9_0"
XSCTH_PROC_microblaze ??= "microblaze_0"

XSCTH_HDF ??= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.hdf"
XSCTH_APP ??= ""
XSCTH_REPO ??= "${S}"
XSCTH_PROJ ??= "${PN}"
XSCTH_WS ??= "${WORKDIR}"
XSCTH_MISC ??= ""
XSCTH_SCRIPT ??= ""
XSCTH_ARCH ?= "${@bb.utils.contains('XSCTH_PROC', 'psu_cortexa53_0', '64', '32', d)}"

PROJ_ARG ??= "-ws ${XSCTH_WS} -pname ${XSCTH_PROJ} -rp ${XSCTH_REPO}"
HW_ARG ??= "-processor ${XSCTH_PROC} -hdf ${XSCTH_HDF} -arch ${XSCTH_ARCH}"

do_configure() {
    export RDI_PLATFORM=lnx64
    export SWT_GTK3=0

    if [ -n "${XSCTH_MISC}" ]; then
        export MISC_ARG="${XSCTH_MISC}"
    fi

    if [ -n "${XSCTH_APP}" ]; then
        export APP_ARG=' -app "${XSCTH_APP}"'
    fi

    echo "MISC_ARG is ${MISC_ARG}"
    echo "APP_ARG is ${APP_ARG}"
    echo "cmd is: xsct ${XSCTH_SCRIPT} ${PROJ_ARG} ${HW_ARG} ${APP_ARG} ${MISC_ARG}"

    flock -x "${WORKDIR}/xsctlock" -c 'eval xsct ${XSCTH_SCRIPT} ${PROJ_ARG} ${HW_ARG} ${APP_ARG} ${MISC_ARG}'
}


do_compile() {
    export RDI_PLATFORM=ln64
    export SWT_GTK3=0
    flock -x "${WORKDIR}/xsctlock" -c 'eval xsct ${XSCTH_SCRIPT} ${PROJ_ARG} -do_compile 1'
}
