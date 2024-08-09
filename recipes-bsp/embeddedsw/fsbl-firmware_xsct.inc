inherit xsctapp xsctyaml

# The makefile does not handle parallelization
PARALLEL_MAKE = "-j1"

B = "${S}/${XSCTH_PROJ}"
B:zynq = "${S}/${XSCTH_PROJ}"
B:zynqmp = "${S}/${XSCTH_PROJ}"

XSCTH_MISC:append = "${@bb.utils.contains('MACHINE_FEATURES', 'rfsoc', ' -lib libmetal', '', d)}"

XSCTH_COMPILER_DEBUG_FLAGS = " -DFSBL_DEBUG_INFO"

XSCTH_APP:zynq   = "Zynq FSBL"
XSCTH_APP:zynqmp = "Zynq MP FSBL"

# Building for zynq does work here
COMPATIBLE_MACHINE:zynq = ".*"

# XSCT version provides it's own toolchain, so can build in any environment
COMPATIBLE_HOST:zynq   = "${HOST_SYS}"
COMPATIBLE_HOST:zynqmp = "${HOST_SYS}"

# Clear this for a Linux build, using the XSCT toolchain
EXTRA_OEMAKE:linux = ""
EXTRA_OEMAKE:linux-gnueabi = ""

# Workaround for hardcoded toolchain items
XSCT_PATH_ADD:append:elf = "\
${WORKDIR}/bin:"

XSCT_PATH_ADD:append:eabi = "\
${WORKDIR}/bin:"

do_configure:prepend:elf:aarch64() {
  mkdir -p ${WORKDIR}/bin
  echo "#! /bin/bash\n${CC} \$@" > ${WORKDIR}/bin/aarch64-none-elf-gcc
  echo "#! /bin/bash\n${AS} \$@" > ${WORKDIR}/bin/aarch64-none-elf-as
  echo "#! /bin/bash\n${AR} \$@" > ${WORKDIR}/bin/aarch64-none-elf-ar
  chmod 0755 ${WORKDIR}/bin/aarch64-none-elf-gcc
  chmod 0755 ${WORKDIR}/bin/aarch64-none-elf-as
  chmod 0755 ${WORKDIR}/bin/aarch64-none-elf-ar
}

ARM_INSTRUCTION_SET:eabi:arm = "arm"
do_configure:prepend:eabi:arm() {
  mkdir -p ${WORKDIR}/bin
  echo "#! /bin/bash\n${CC} \$@" > ${WORKDIR}/bin/arm-none-eabi-gcc
  echo "#! /bin/bash\n${AS} \$@" > ${WORKDIR}/bin/arm-none-eabi-as
  echo "#! /bin/bash\n${AR} \$@" > ${WORKDIR}/bin/arm-none-eabi-ar
  chmod 0755 ${WORKDIR}/bin/arm-none-eabi-gcc
  chmod 0755 ${WORKDIR}/bin/arm-none-eabi-as
  chmod 0755 ${WORKDIR}/bin/arm-none-eabi-ar
}

# xsctapp sets it's own do_install, replace it with the real one (from meta-xilinx-standalone)
do_install() {
    :
}

# Override the default with the specific component name and path XSCT puts out
# this path is within the B directory
ESW_COMPONENT = "${XSCTH_PROJ}/executable.elf"

# xsctapp sets it's own do_deploy, replace it with the real one (from meta-xilinx-standalone)
do_deploy() {
    install -Dm 0644 ${B}/${ESW_COMPONENT} ${DEPLOYDIR}/${FSBL_BASE_NAME}.elf
    ln -sf ${FSBL_BASE_NAME}.elf ${DEPLOYDIR}/${FSBL_IMAGE_NAME}.elf
}

addtask deploy before do_build after do_install

python() {
    if not d.getVar('PV').startswith(d.getVar('XILINX_XSCT_VERSION')):
        raise bb.parse.SkipRecipe("Recipe version %s is not compatible with XILINX_XSCT_VERSION %s" % (d.getVar('PV'), d.getVar("XILINX_XSCT_VERSION")))
} 
