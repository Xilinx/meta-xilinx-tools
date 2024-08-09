inherit xsctapp xsctyaml

# The makefile does not handle parallelization
PARALLEL_MAKE = "-j1"

B = "${S}/${XSCTH_PROJ}"

XSCTH_MISC:append = "${@bb.utils.contains('MACHINE_FEATURES', 'rfsoc', ' -lib libmetal', '', d)}"

XSCTH_COMPILER_DEBUG_FLAGS = "-DDEBUG_MODE -DXPFW_DEBUG_DETAILED"
XSCTH_PROC_IP = "psu_pmu"
XSCTH_APP  = "ZynqMP PMU Firmware"

YAML_COMPILER_FLAGS:append = " -DENABLE_SCHEDULER "

# XSCT version provides it's own toolchain, so can build in any environment
COMPATIBLE_HOST:zynqmp = "${HOST_SYS}"

# Clear this for a Linux build, using the XSCT toolchain
EXTRA_OEMAKE:linux = ""

# Workaround for hardcoded toolchain items
XSCT_PATH_ADD:append:elf = "\
${WORKDIR}/bin:"

MB_OBJCOPY = "mb-objcopy"

do_configure:prepend:elf() {
  mkdir -p ${WORKDIR}/bin
  echo "#! /bin/bash\n${CC} \$@" > ${WORKDIR}/bin/mb-gcc
  echo "#! /bin/bash\n${AS} \$@" > ${WORKDIR}/bin/mb-as
  echo "#! /bin/bash\n${AR} \$@" > ${WORKDIR}/bin/mb-ar
  echo "#! /bin/bash\n${OBJCOPY} \$@" > ${WORKDIR}/bin/mb-objcopy
  chmod 0755 ${WORKDIR}/bin/mb-gcc
  chmod 0755 ${WORKDIR}/bin/mb-as
  chmod 0755 ${WORKDIR}/bin/mb-ar
  chmod 0755 ${WORKDIR}/bin/mb-objcopy
}

do_compile:append() {
    ${MB_OBJCOPY} -O binary ${B}/${ESW_COMPONENT} ${B}/${ESW_COMPONENT}.bin
}

ESW_COMPONENT = "${XSCTH_PROJ}/executable.elf"

# xsctapp sets it's own do_install, replace it with the real one
do_install() {
    :
}

# Duplicate from pmu-firmware.inc in meta-xilinx-standalone (replaces the version from xsctapp.bbclass)
do_deploy() {
    install -Dm 0644 ${B}/${ESW_COMPONENT} ${DEPLOYDIR}/${PMU_FIRMWARE_BASE_NAME}.elf
    ln -sf ${PMU_FIRMWARE_BASE_NAME}.elf ${DEPLOYDIR}/${PMU_FIRMWARE_IMAGE_NAME}.elf
    install -m 0644 ${B}/${ESW_COMPONENT}.bin ${DEPLOYDIR}/${PMU_FIRMWARE_BASE_NAME}.bin
    ln -sf ${PMU_FIRMWARE_BASE_NAME}.bin ${DEPLOYDIR}/${PMU_FIRMWARE_IMAGE_NAME}.bin
}

addtask deploy before do_build after do_install

python() {
    if not d.getVar('PV').startswith(d.getVar('XILINX_XSCT_VERSION')):
        raise bb.parse.SkipRecipe("Recipe version %s is not compatible with XILINX_XSCT_VERSION %s" % (d.getVar('PV'), d.getVar("XILINX_XSCT_VERSION")))
}
